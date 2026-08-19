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
          model = "ollama/qwen2.5-coder:7b-instruct-q4_K_M";
          autoshare = false;
          autoupdate = true;
          provider = {
            ollama = {
              npm = "@ai-sdk/openai-compatible";
              options.baseURL = "http://localhost:11434/v1";
              models."qwen2.5-coder:7b-instruct-q4_K_M" = { };
            };
          };
        };
      };

      services.ollama = {
        enable = true;
        package = pkgs.ollama-vulkan;
        acceleration = "vulkan";
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
