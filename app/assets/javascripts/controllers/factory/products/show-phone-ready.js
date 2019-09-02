import stickybits from 'stickybits'
import { Controller } from 'stimulus'

stickybits('#sti')

class InputController extends Controller {
  static targets = [ 'output' ]

  connect() {
    console.log('InputController connected!')
  }

  toggle(event) {
    let checkbox = event.currentTarget
    if (checkbox.checked) {
      let cl = checkbox.parentElement.classList
      cl.remove('weui-btn_default')
      cl.add('weui-btn_primary')
    } else if (!checkbox.checked) {
      let cl = checkbox.parentElement.classList
      cl.remove('weui-btn_primary')
      cl.add('weui-btn_default')
    }
  }

  disable() {
    if (this.outputTarget.disabled === true) {
      input.parentElement.classList.add('weui-btn_disabled')
    }
  }
}

application.register('input', InputController)
