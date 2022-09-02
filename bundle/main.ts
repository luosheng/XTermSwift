import { Terminal } from 'xterm'

import 'xterm/css/xterm.css'

const main = () => {
  const term = new Terminal()
  term.open(document.getElementById('terminal')!)

  term.onData(data => {
    window.webkit.messageHandlers.xtermOnData.postMessage(data)
  })
}

main()
