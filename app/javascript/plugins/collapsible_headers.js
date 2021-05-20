
const swapClassesOnClick = (event) => {
  let button = event.currentTarget;
  let header = event.currentTarget.nextElementSibling;
  header.classList.toggle("active-card");
  console.log(header.classList.contains("active-card"));
  if (header.classList.contains("active-card")){
    button.innerHTML = '<i class="fas fa-eye"></i>';
  } else {
    button.innerHTML = '<i class="fas fa-eye-slash"></i>';
  };
};

const collapseHeaders = () => {
  const collapsibles = document.querySelectorAll(".collapsible");
  console.log(collapsibles);
  collapsibles.forEach(collapsible =>{
    collapsible.addEventListener("click", swapClassesOnClick)
  });
}

export { collapseHeaders }