import { Terminal } from 'xterm'
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
  }
}
