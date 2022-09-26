import { ITheme, Terminal } from 'xterm'

export class TermHelper {
  private term: Terminal

  constructor(term: Terminal) {
    this.term = term
  }

  applyTheme(theme: ITheme) {
    this.term.options.theme = theme
    window.document.body.setAttribute('style', `background-color: ${theme.background ?? '#FFFFFF'}`)
  }
}
