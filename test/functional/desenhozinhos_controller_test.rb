require 'test_helper'

class DesenhozinhosControllerTest < ActionController::TestCase
  setup do
    @desenhozinho = desenhozinhos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:desenhozinhos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create desenhozinho" do
    assert_difference('Desenhozinho.count') do
      post :create, desenhozinho: @desenhozinho.attributes
    end

    assert_redirected_to desenhozinho_path(assigns(:desenhozinho))
  end

  test "should show desenhozinho" do
    get :show, id: @desenhozinho
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @desenhozinho
    assert_response :success
  end

  test "should update desenhozinho" do
    put :update, id: @desenhozinho, desenhozinho: @desenhozinho.attributes
    assert_redirected_to desenhozinho_path(assigns(:desenhozinho))
  end

  test "should destroy desenhozinho" do
    assert_difference('Desenhozinho.count', -1) do
      delete :destroy, id: @desenhozinho
    end

    assert_redirected_to desenhozinhos_path
  end
end
