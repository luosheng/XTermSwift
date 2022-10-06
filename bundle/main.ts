import { ITheme, Terminal } from 'xterm'
import { WebLinksAddon } from './addons/WebLinksAddon'
import { TermHelper } from './term-helper'

import 'xterm/css/xterm.css'

const main = () => {
  const term = new Terminal()
  window.term = term

  window.termHelper = new TermHelper(term)
  term.loadAddon(new WebLinksAddon())

  term.open(document.getElementById('terminal')!)

  term.onData(data => {
    window.webkit.messageHandlers.dataHandler.postMessage(data)
  })

  window.webkit.messageHandlers.readyHandler.postMessage(null)
}

main()
