import { ITheme, Terminal } from 'xterm'
import { FitAddon } from 'xterm-addon-fit'
import { WebLinksAddon } from './addons/WebLinksAddon'
export class TermWrapper {
  private term = new Terminal()
  private fitAddon = new FitAddon()

  constructor(dom: HTMLElement) {
    this.term.loadAddon(this.fitAddon)
    this.term.loadAddon(new WebLinksAddon())

    this.term.open(dom)

    this.requestSizeFit()
    window.addEventListener('resize', this.requestSizeFit.bind(this))

    this.term.onData(data => {
      globalThis.webkit.messageHandlers.dataHandler.postMessage(data)
    })

    globalThis.webkit.messageHandlers.readyHandler.postMessage(null)
  }

  applyTheme(theme: ITheme) {
    this.term.options.theme = theme
    window.document.body.setAttribute('style', `background-color: ${theme.background ?? '#FFFFFF'}`)
  }

  setFont(fontFamily: string, fontSize: number) {
    this.term.options.fontFamily = fontFamily
    this.term.options.fontSize = fontSize
    this.requestSizeFit()
  }

  async write(data: string) {
    return new Promise(resolve => {
      this.term.write(data, () => {
        resolve(void 0)
      })
    })
  }

  async requestSizeFit() {
    this.fitAddon.fit()
    const { cols, rows } = this.term
    globalThis.webkit.messageHandlers.sizeUpdateHandler.postMessage({ cols, rows })
  }

  async clear() {
    this.term.clear()
  }
}
