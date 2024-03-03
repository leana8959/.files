{llama-cpp, ...}: {
  environment.userLaunchAgents = {
    "llama-server.plist" = {
      enable = false;
      text = ''
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
            <dict>
                <key>Label</key> <string>org.nix.llama-server</string>

                <key>ProgramArguments</key>
                <array>
                    <string>${llama-cpp}/bin/llama-server</string>
                    <string>--model</string>
                    <string>/Users/leana/llm/mistral_7B-Q4_K_M.gguf</string>
                </array>

                <key>RunAtLoad</key> <true/>

                <key>KeepAlive</key> <true/>

                <key>ThrottleInterval</key> <integer>60</integer>
            </dict>
        </plist>
      '';
    };
  };
}
