import { ITheme, Terminal } from 'xterm'
import { FitAddon } from 'xterm-addon-fit'
import { WebLinksAddon } from './addons/WebLinksAddon'
import { TermHelper } from './term-helper'

import 'xterm/css/xterm.css'

const main = () => {
  const term = new Terminal()
  window.term = term

  window.termHelper = new TermHelper(term)

  const fitAddon = new FitAddon()
  term.loadAddon(fitAddon)
  term.loadAddon(new WebLinksAddon())

  term.open(document.getElementById('terminal')!)

  const fitAndReport = () => {
    fitAddon.fit()
    const { cols, rows } = term
    window.webkit.messageHandlers.sizeUpdateHandler.postMessage({ cols, rows })
  }

  fitAndReport()
  window.addEventListener('resize', fitAndReport)

  term.onData(data => {
    window.webkit.messageHandlers.dataHandler.postMessage(data)
  })

  window.webkit.messageHandlers.readyHandler.postMessage(null)
}

main()
