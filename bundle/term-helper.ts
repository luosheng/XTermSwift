import { ITheme, Terminal } from 'xterm'
import { FitAddon } from 'xterm-addon-fit'
export class TermHelper {
  private term: Terminal
  private fitAddon = new FitAddon()

  constructor(term: Terminal) {
    this.term = term
    this.term.loadAddon(this.fitAddon)

    this.requestSizeFit()
    window.addEventListener('resize', this.requestSizeFit.bind(this))
  }

  applyTheme(theme: ITheme) {
    this.term.options.theme = theme
    window.document.body.setAttribute('style', `background-color: ${theme.background ?? '#FFFFFF'}`)
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
    window.webkit.messageHandlers.sizeUpdateHandler.postMessage({ cols, rows })
  }
}
