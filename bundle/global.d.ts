import { Terminal } from '@xterm/xterm'
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
    } | undefined
    terminal: TermWrapper
  }
}
