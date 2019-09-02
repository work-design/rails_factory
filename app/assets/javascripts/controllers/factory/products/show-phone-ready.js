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
      this.toggleOn(checkbox)
    } else if (!checkbox.checked) {
      this.toggleOffCss(checkbox)
    }

    Rails.fire(checkbox.form, 'submit')
  }

  toggleOn(checkbox) {
    let cl = checkbox.parentElement.classList
    cl.remove('weui-btn_default')
    cl.add('weui-btn_primary')

    if (this.size >= this.range[1]) {
      this.toggleOff(this.lastItem)
    }

    let order = this.data.get('order').split(',')
    order.push(checkbox.value)
    this.data.set('order', order)
  }

  toggleOff(checkbox) {
    checkbox.checked = false
    this.toggleOffCss(checkbox)
  }

  toggleOffCss(checkbox) {
    let cl = checkbox.parentElement.classList
    cl.remove('weui-btn_primary')
    cl.add('weui-btn_default')

    let order = this.data.get('order').split(',')
    let index = order.indexOf(checkbox.value)
    if (index > -1) {
      order.splice(index, 1)
    }
    this.data.set('order', order)
  }

  disable() {
    let input = this.outputTarget;
    input.disabled = true;
    input.parentElement.parentElement.classList.add('weui-cell_disabled')
  }

  get range() {
    let arr = []
    let r = this.data.get('range').split(',')
    r.forEach((i) => {
      arr.push(parseInt(i))
    })
    return arr
  }

  get size() {
    return this.data.get('order').split(',').length
  }

  get lastItem() {
    let id = this.data.get('order').split(',')[0]
    return document.getElementById(`part_${id}`)
  }
}

application.register('input', InputController)
