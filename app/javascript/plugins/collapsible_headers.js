
const swapClassesOnClick = (event) => {
  let header = event.currentTarget.nextElementSibling;
  header.classList.toggle("active-card");
};

const collapseHeaders = () => {
  const collapsibles = document.querySelectorAll(".collapsible");
  console.log(collapsibles);
  collapsibles.forEach(collapsible =>{
    collapsible.addEventListener("click", swapClassesOnClick)
  });
}

export { collapseHeaders }