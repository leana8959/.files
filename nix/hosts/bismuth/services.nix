{llama-cpp, ...}: {
  # https://apple.stackexchange.com/questions/290945/what-are-the-differences-between-launchagents-and-launchdaemons
  # https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/DesigningDaemons.html#//apple_ref/doc/uid/10000172i-SW4-BBCBHBFB
  environment.userLaunchAgents = {
    llama-server = {
      enable = false;
      target = "llama-server.plist";
      text = ''
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
            <dict>
                <key>Label</key>
                <string>ggerganov.llama-server</string>
                <key>ProgramArguments</key>
                <array>
                    <string>${llama-cpp}/bin/llama-server</string>
                    <string>--model</string>
                    <string>/Users/leana/llm/mistral_7B-Q4_K_M.gguf</string>
                </array>
                <key>RunAtLoad</key>
                <true/>
                <key>KeepAlive</key>
                <true/>
                <key>ThrottleInterval</key>
                <integer>60</integer>
            </dict>
        </plist>
      '';
    };
  };
}
