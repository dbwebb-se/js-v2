/**
 * @module hangman
 */

const hangman = {
  partAsElement: {
    hill: document.getElementById('hang_hill'),
    gallow: document.getElementById('hang_construction'),
    body: document.getElementById('hang_body'),
    rightarm: document.getElementById('hang_rightarm'),
    leftarm: document.getElementById('hang_leftarm'),
    rightleg: document.getElementById('hang_rightleg'),
    leftleg: document.getElementById('hang_leftleg'),
    rope: document.getElementById('hang_rope'),
    head: document.getElementById('hang_head')
  },
  validParts: [
    'hill',
    'gallow',
    'body',
    'rightarm',
    'leftarm',
    'rightleg',
    'leftleg',
    'rope',
    'head'
  ],
  isValid: function (part) {
    if (this.validParts.indexOf(part) === -1) {
      console.log('The part is not valid: ' + part)
      return false
    }
    console.log('The part is valid: ' + part)
    return true
  },

  /**
   * Hide a part.
   * @param {string} part Name of the part to hide.
   */
  hide: function (part) {
    if (this.isValid(part)) {
      console.log('Hiding part: ' + part)
      this.partAsElement[part].style.display = 'none'
    }
  },

  /**
   * Show a part.
   * @param {string} part Name of the part to show.
   */
  show: function (part) {
    if (this.isValid(part)) {
      console.log('Showing part: ' + part)
      this.partAsElement[part].style.display = 'inline'
    }
  }
}

export { hangman }
