import stickybits from 'stickybits'
import { Controller } from 'stimulus'

stickybits('#sti')

class InputController extends Controller {
  static targets = [ 'output' ]

  connect() {
    console.log('InputController connected!')
  }

  toggle() {

  }

  disable() {
    if (this.outputTarget.disabled === true) {
      input.parentElement.parentElement.classList.add('weui-btn_disabled')
    }
  }
}

application.register('input', InputController)
