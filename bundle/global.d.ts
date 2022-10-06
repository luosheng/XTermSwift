import { Terminal } from 'xterm'
import { TermWrapper } from './term-helper'
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
    terminal: TermWrapper
  }
}
