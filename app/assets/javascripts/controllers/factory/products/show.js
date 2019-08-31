import stickybits from 'stickybits'
import { Controller } from 'stimulus'

stickybits('#sti')

class InputController extends Controller {
  static targets = [ 'output' ]

  connect() {
    this.disable()
  }

  disable() {
    if (this.outputTarget.disabled === true) {
      disableClass(this)
    }
  }

  disableClass(input) {
    input.parentElement.parentElement.classList.add('weui-cell_disabled')
  }
}

application.register('input', InputController)
