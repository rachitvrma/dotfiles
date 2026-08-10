{
  flake.homeModules.ai =
    { pkgs, ... }:
    {
      programs.opencode = {
        enable = true;
        package = pkgs.opencode;
        extraPackages = with pkgs; [
          ripgrep
          fd
          git
          jq
        ];
        web = {
          enable = true;
          extraArgs = [
            "--port"
            "4096"
            "--mdns"
          ];
        };
        context = ''
          - Prefer Nix syntax highlighting.
          - Never commit secrets or generated files.
          - Run `nix flake check` before considering a change done.
        '';
        settings = {
          # Default model: cheap/local for routine edits.
          # Override per-session with /models when you need Groq for
          # harder reasoning or larger context.
          model = "ollama/qwen2.5-coder:7b";

          provider = {
            ollama = {
              npm = "@ai-sdk/openai-compatible";
              name = "Ollama (local)";
              options.baseURL = "http://127.0.0.1:11434/v1";
              models = {
                "qwen2.5-coder:7b" = {
                  name = "Qwen2.5 Coder 7B";
                  limit = {
                    context = 16384;
                    output = 4096;
                  };
                };
                "qwen2.5-coder:3b" = {
                  name = "Qwen2.5 Coder 3B (fast)";
                  limit = {
                    context = 8192;
                    output = 2048;
                  };
                };
              };
            };
            # groq and openrouter are built into OpenCode's provider
            # registry already — no config needed here. Auth with:
            #   opencode
            #   > /connect  (search "Groq" / "OpenRouter")
            # This writes keys to ~/.local/share/opencode/auth.json,
            # never into the Nix store.
          };

          autoshare = false;
          autoupdate = true;
        };
      };

      services.ollama = {
        enable = true;
        package = pkgs.ollama-vulkan;
        # acceleration = "vulkan";
        environmentVariables = {
          OLLAMA_KEEP_ALIVE = "10m";
          # Cap memory pressure: never load more than one model,
          # never run parallel requests against it.
          OLLAMA_MAX_LOADED_MODELS = "1";
          OLLAMA_NUM_PARALLEL = "1";
          # Context window ollama exposes by default (4096) is too
          # small for agentic tool calling; this raises the floor.
          # Individual model `limit.context` in opencode.json still caps
          # what OpenCode will request.
          OLLAMA_CONTEXT_LENGTH = "16384";
        };
      };
    };
}
