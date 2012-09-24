class DesenhozinhosController < ApplicationController
  # GET /desenhozinhos
  # GET /desenhozinhos.json
  def index
    @desenhozinhos = Desenhozinho.all
    if Desenhozinho.count==0
      @anumd = 1
    else
      @anumd = Desenhozinho.maximum("NumDesenho_id")+1
    end
   

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @desenhozinhos }
    end
  end

  def show
    @desenhozinho = Desenhozinho.find(params[:id])
    
    if Desenhozinho.count==0
      @anumd = 1
    else
      @anumd = @desenhozinho.NumDesenho_id
    end

    @coords=@desenhozinho.pontinhos.map {|p| [p.CX,p.CY]}
    @coords = @coords.flatten

    render "index"
  end
  
  # POST /desenhozinhos
  # POST /desenhozinhos.json
  def create
    if Desenhozinho.count==0
      @anumd = 1
    else
      @anumd = Desenhozinho.maximum("NumDesenho_id")+1
    end
    @desenhozinho=Desenhozinho.create(:NumDesenho_id=>@anumd , :NomeDesenho=>"Desenho #{@anumd.to_s}")
    @ada=params[:ada].split(",").map {|s| s.to_i}
    i=0

    while i<=@ada.length-1
        @desenhozinho.pontinhos.create(:NumPonto=>(i+2)/2 , :CX=>@ada[i] , :CY=>@ada[i+1])
        i=i+2     
    end
    @anumd = @anumd+1
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
    @anumd=1
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
