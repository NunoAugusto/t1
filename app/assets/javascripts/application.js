// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
var DesenhoActual = new Array(); //estrutura para guardar o desenho atual recoorre-se ao constutor coordenada

var strHTML="";

 //numero de cliques no canvas que é igual ao num de pts do desenho
var NumClick=0;
var LastX=0; //para guardar o ultimo ponto de modo a fazer o desenho
var LastY=0;

document.addEventListener("DOMContentLoaded", init, false); //o orelhas dos eventos
var ctx; //contexto do canvas
var BLA;
// DEFINIÇÃO DE FUNÇÕES

function init() //está sempre À espera do clique no canvas com o listener
      {
        var canvas = document.getElementById("myCanvas");
        canvas.addEventListener("mousedown", getPosition, false);
        ctx=canvas.getContext("2d");
      }
// Constroi a coordenada 
function coordenada( pini, pfim ) {
   this.pini = pini;
   this.pfim = pfim;
}

function getPosition(event) //DISPARA COM UM CLIQUE NO CANVAS
{
   
    var totalOffsetX = 0;
    var totalOffsetY = 0;
    var canvasX = 0;
    var canvasY = 0;
    var currentElement = this;
    //detetar a coordenada no canvas
    do{
        totalOffsetX += currentElement.offsetLeft;
        totalOffsetY += currentElement.offsetTop;
      }
    while(currentElement = currentElement.offsetParent)

    canvasX = event.pageX - totalOffsetX;
    canvasY = event.pageY - totalOffsetY;
  
    if (NumClick>0)
    { 
      //A ESCREVER no canvas");
      ctx.beginPath(); 
      ctx.lineWidth="3";
      ctx.strokeStyle="blue"; 
      ctx.moveTo(LastX,LastY);
      ctx.lineTo(canvasX,canvasY);
      ctx.stroke(); // Draw it
      
    }
    else
    {
   
    }
  
    //Actualiza 
    LastX=canvasX;
    LastY=canvasY;
  
   
    DesenhoActual[NumClick] = new coordenada(canvasX,canvasY);
    NumClick=NumClick+1; 
    

    return true

}

$(function () 
{
  $('#GuardaLimpaID').click(function ()
  {
  var CodigoContrutor;  
  if (NumClick<2)
    {
      alert("O seu desenho actual não pode ser guardado pois não tem um segmento de recta criado")
      return false
    }
  else
    {
      //constroi o array com os pontos das coordenadas do desenho actual que se encontra no canvas
      strHTML="";
      for (i=0; i<NumClick-1 ; i++)
          {     
          //numpontonodpesenho,x,y  
          strHTML+= DesenhoActual[i].pini+","+DesenhoActual[i].pfim+","; 
          // DesenhoActual[i].pini.string + "," + DesenhoActual[i].pfim.string);    
          }  
         
      strHTML+= DesenhoActual[NumClick-1].pini+","+DesenhoActual[NumClick-1].pfim+"";
      
      document.getElementById("ArrayId").value=strHTML;
      
      ctx.fillStyle="white";  
      ctx.fillRect(0,0,400,200);
      NumClick=0;
     
      return true
    }
  })
});

function DesenhaCanvas(adesenho) //recebe um array de coordenadas ordenado e escreve no canvas as linhas correspondentes a esses pontos
 { 
  if (adesenho.length==0)
  {
  }
  else
  {  
    ctx.fillStyle="white";  
    ctx.fillRect(0,0,400,200);
    DesenhoActual = new Array();
    for (i = 0; i<(adesenho.length)-3; i=i+2) {

   
      //desenha no canvas a partir dos pontos que vieram em adesenho
      ctx.beginPath(); 
      ctx.lineWidth="3";
      ctx.strokeStyle="blue"; 
      ctx.moveTo(adesenho[i],adesenho[i+1]);
      ctx.lineTo(adesenho[i+2],adesenho[i+3]);
      ctx.stroke(); // Draw it
  
      LastX=parseInt(adesenho[i+2]);
      LastY=parseInt(adesenho[i+3]);
                 
      };
    
    //actualiza a var global com o desenho actual para continuar a desenhar-se
    for (i = 0; i<((adesenho.length)/2); i=i+1) {
       
      DesenhoActual[i]=new coordenada(adesenho[i*2],adesenho[i*2+1]);       
    }
    NumClick=(adesenho.length/2);
    
  }
}  

$(function () 
{
  $('#ApagaTudoID').click(function () 
  {
  var r=confirm("Atenção deseja mesmo apagar todos os desenhos da Base de Dados?");
  if (r==true)
      {   
      NumClick=0;
      //LIMPA DESENHO
      ctx.fillStyle="white";
      ctx.fillRect(0,0,400,200);
     }

  else
     {  
     }
  return r    
 })
});
