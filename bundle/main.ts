import { TermWrapper } from './term-helper'

import 'xterm/css/xterm.css'

const main = () => {
  let background = window.location.hash
  document.body.setAttribute('style', `background-color: ${background ?? '#FFFFFF'}`)
  globalThis.terminal = new TermWrapper(document.getElementById('terminal')!, {
    background
  })
}

main()
