const changePic = () => {
  let mainPicture = document.getElementsByClassName('picture')[0];
  let smallPictures = Array.from(document.getElementsByClassName('small-pic'));
  smallPictures.forEach((picture) => {
    picture.addEventListener('click', () => {
      let picSource = picture.src;
      mainPicture.src = picSource;
    })
  })
}

export { changePic }
