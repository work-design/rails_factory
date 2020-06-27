import { Controller } from 'stimulus'

class CustomController extends Controller {
  static targets = [ 'output' ]

  connect() {
    console.debug('Custom Controller connected!')
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

    if (this.size >= this.range[1] && this.lastItem) {
      this.toggleOff(this.lastItem)
    }

    let order = this.data.get('order')
    if (order.length > 0) {
      order = order.split(',')
    } else {
      order = []
    }
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

    let order = this.data.get('order')
    if (order.length > 0) {
      order = order.split(',')
    } else {
      order = []
    }
    let index = order.indexOf(checkbox.value)
    if (index > -1) {
      order.splice(index, 1)
    }
    this.data.set('order', order)
  }

  disable() {
    let input = this.outputTarget
    input.disabled = true
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

application.register('custom', CustomController)
