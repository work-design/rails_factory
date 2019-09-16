import { Controller } from 'stimulus'

class SwipeController extends Controller {
  static targets = ['open']

  connect() {
    console.log('SwipeController works!')
  }

  start(event) {
    let touch = event.targetTouches[0]
    this.startPos = {
      x: touch.pageX,
      y: touch.pageY
    }
  }

  // data-action="touchmove->swipe#left touchstart->swipe#start"
  left(event) {
    if (event.targetTouches.length > 1 || event.scale && event.scale !== 1) {
      return
    }
    let touch = event.targetTouches[0]
    let endPos = {
      x: touch.pageX - this.startPos.x,
      y: touch.pageY - this.startPos.y
    }
    let isScrolling = Math.abs(endPos.x) < Math.abs(endPos.y) ? 1 : 0
    if (isScrolling === 0) {
      event.preventDefault()
      this.openTarget.style.display = 'block'
      this.openTarget.style.width = '30px'
    }
  }

  get startPos() {
    let r = this.data.get('startPos').split(',')
    return {
      x: parseFloat(r[0]),
      y: parseFloat(r[1])
    }
  }

  set startPos(pos) {
    this.data.set('startPos', [pos.x, pos.y].join(','))
  }

}

application.register('swipe', SwipeController)
