let
  c1 = "\\e{lightblue}";
  c2 = "\\e{lightcyan}";
  res = "\\e{reset}";
in
''

${c1}          ▗▄▄▄       ${c2}▗▄▄▄▄    ▄▄▄▖${res}
${c1}          ▜███▙       ${c2}▜███▙  ▟███▛${res}                        ${c1}TTY:${res}       \e{bold}\l${res}
${c1}           ▜███▙       ${c2}▜███▙▟███▛${res}                         ${c2}Time:${res}      \e{halfbright}\d \t${res}
${c1}            ▜███▙       ${c2}▜██████▛${res}                          ${c2}Distr${res}      \e{halfbright}\S{PRETTY_NAME} \m${res}
${c1}     ▟█████████████████▙ ${c2}▜████▛     ${c1}▟▙${res}                    ${c2}Kernal:${res}    \e{halfbright}\s \r${res}
${c1}    ▟███████████████████▙ ${c2}▜███▙    ${c1}▟██▙${res}                   ${c2}WM:${res}        \e{halfbright}dwm${res}
${c1}           ▄▄▄▄▖           ▜███▙  ${c1}▟███▛${res}
${c1}          ▟███▛             ▜██▛ ${c1}▟███▛${res}
${c1}         ▟███▛               ▜▛ ${c1}▟███▛${res}
${c1}▟███████████▛                  ${c1}▟██████████▙${res}
${c1}▜██████████▛                  ${c1}▟███████████▛${res}
${c1}      ▟███▛ ${c1}▟▙               ▟███▛${res}
${c1}     ▟███▛ ${c1}▟██▙             ▟███▛${res}
${c1}    ▟███▛  ${c1}▜███▙           ▝▀▀▀▀${res}
${c1}    ▜██▛    ${c1}▜███▙ ${c2}▜██████████████████▛${res}
${c1}     ▜▛     ${c1}▟████▙ ${c2}▜████████████████▛${res}
${c1}           ▟██████▙       ${c2}▜███▙${res}
${c1}          ▟███▛▜███▙       ${c2}▜███▙${res}
${c1}         ▟███▛  ▜███▙       ${c2}▜███▙${res}
${c1}         ▝▀▀▀    ▀▀▀▀▘       ${c2}▀▀▀▘${res}



\e{bold}What's the password, dipshit?\e{reset}''