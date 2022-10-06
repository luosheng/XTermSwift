import { TermHelper } from './term-helper'

import 'xterm/css/xterm.css'

const main = () => {
  globalThis.termHelper = new TermHelper(document.getElementById('terminal')!)
}

main()
