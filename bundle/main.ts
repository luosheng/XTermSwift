import { TermWrapper } from './term-helper'

import 'xterm/css/xterm.css'

const main = () => {
  let background = window.location.hash
  globalThis.terminal = new TermWrapper(document.getElementById('terminal')!, {
    background
  })
}

main()
