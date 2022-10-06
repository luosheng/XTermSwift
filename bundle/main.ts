import { TermWrapper } from './term-helper'

import 'xterm/css/xterm.css'

const main = () => {
  globalThis.terminal = new TermWrapper(document.getElementById('terminal')!)
}

main()
