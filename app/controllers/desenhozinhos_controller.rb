class DesenhozinhosController < ApplicationController
  # GET /desenhozinhos
  # GET /desenhozinhos.json
  def index
    @desenhozinhos = Desenhozinho.all  

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @desenhozinhos }
    end
  end

  def show
    @desenhozinho = Desenhozinho.find(params[:id])
    
    #enviar o desenho para o canvas com a func js
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @desenhozinho }
    end
  end
  
  # POST /desenhozinhos
  # POST /desenhozinhos.json
  def create
    @desenhozinho=Desenhozinho.create(:NumDesenho_id=>($anumd) , :NomeDesenho=>"Desenho #{$anumd.to_s}")
    $ada=params[:ada].split(",").map {|s| s.to_i}
    i=0

    while i<=$ada.length-1
        Pontinho.create(:NumDesenho=>$anumd ,:NumPonto=>(i+2)/2 , :CX=>$ada[i] , :CY=>$ada[i+1])
        i=i+2     
    end
    respond_to do |format|
      format.html {render action: "index"}# index.html.erb
      format.json { render json: @desenhozinhos }
    end     
  end

  # PUT /desenhozinhos/1
  # PUT /desenhozinhos/1.json
  def update
    @desenhozinho = Desenhozinho.find(params[:id])

    respond_to do |format|
      if @desenhozinho.update_attributes(params[:desenhozinho])
        format.html { redirect_to @desenhozinho, notice: 'Desenhozinho was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @desenhozinho.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /desenhozinhos/1
  # DELETE /desenhozinhos/1.json

  def destroy
    @desenhozinhos=Desenhozinho.all
    @pontinhos=Pontinho.all
    if Desenhozinho.exists?
        @desenhozinhos.each do |d|
            d.destroy
            d.save
        end
        
        @pontinhos.each do |p|
            p.destroy
            p.save
        end 


    end 
    respond_to do |format|
      format.html {render action: "index"}# index.html.erb
      format.json { render json: @desenhozinhos }
    end  
  end
end
