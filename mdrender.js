/* 
 deps: showdown.min.js
  qm=$(ipfs add -Q -w -r showdown.*)
  ipfs object patch add-link QmUNLLsPACCz1vLxQVkXqqLX5R1X345qqfHbsf67hvA3Nn js $qm
*/
var div = document.getElementsByTagName('div')[0];
var code = div.getElementsByTagName('code')[0];
var converter = new showdown.Converter();
div.innerHTML = converter.makeHtml(code.innerText);
