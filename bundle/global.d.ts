import { Terminal } from 'xterm'
import { TermHelper } from './term-helper'
export { }

declare global {
  interface Window {
    webkit: {
      messageHandlers: {
        [key: string]: {
          postMessage(data: any): void
        }
      }
    }
    term: Terminal
    termHelper: TermHelper
  }
}
