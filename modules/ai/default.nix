{ lib, pkgs, ... }:
let
  llama-cpp-pkg = pkgs.llama-cpp-vulkan;
  port = 9081;
  ctx-size = 128; # 32
  hf-file = "gemma-3-4b-it-Q4_K_M.gguf";
  hf-repo =
    "unsloth/gemma-3-4b-it-GGUF";
    # "itlwas/Phi-4-mini-instruct-Q4_K_M-GGUF";
    # "unsloth/gemma-3-4b-it-GGUF";
    # "yasserrmd/DeepSeek-7B-1M-gguf";
    # "unsloth/Seed-Coder-8B-Instruct-GGUF";
  api-key = "foobar";

  llama-start-server = pkgs.writeShellScriptBin "llama-start-server" ''
    exec ${llama-cpp-pkg}/bin/llama-server --log-disable \
      --port ${toString port} \
      --hf-repo ${hf-repo} \
      ${if hf-file != "" then "--hf-file ${hf-file}" else ""} \
      --ctx-size ${toString (ctx-size * 1024)} \
      --api-key ${api-key} \
      --threads 12 --no-perf
  '';
  llama-start-server-background = pkgs.writeShellScriptBin "llama-start-server-background" ''
    is_running() { ${pkgs.lsof}/bin/lsof -i ":${toString port}" >/dev/null 2>&1; }

    if ! is_running; then
      setsid -f ${llama-start-server}/bin/llama-start-server >"$HOME/.local/state/local-ai-logs" 2>&1

      attempts=20;
      while ! ([ "$attempts" == "0" ] || is_running); do
        sleep 5;
        attempts=$((attempts - 1));
      done
    fi
  '';
in
{
  environment.systemPackages = with pkgs; [
    llama-cpp-pkg
    llama-start-server
    llama-start-server-background
    aichat
    piper-tts
  ];

  environment.variables = {
    AI_API_URL = "http://localhost:${toString port}";
    AI_API_KEY = api-key;
  };
}
