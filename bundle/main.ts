import { Terminal } from 'xterm'
import { FitAddon } from 'xterm-addon-fit'

import 'xterm/css/xterm.css'

const main = () => {
  const term = new Terminal()
  const fitAddon = new FitAddon()
  term.loadAddon(fitAddon)
  term.open(document.getElementById('terminal')!)
  fitAddon.fit()

  term.onData(data => {
    window.webkit.messageHandlers.xtermOnData.postMessage(data)
  })

  window.addEventListener('resize', () => {
    fitAddon.fit()
  })
}

main()
