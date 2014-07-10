require 'rails_helper'

describe Cart do
  context "#get" do
    context "для не авторизованный" do
      let(:cart) { create(:cart, user_id: nil) }

      it "создает корзину если ее нет" do
        expect(Cart.get.id).not_to eq nil
      end

      it "возвращает существующую корзину" do
        cart
        expect(Cart.get(cart.id)).to eq cart
      end
    end

    context "для авторизованного" do
      let(:cart) { create(:cart, user_id: nil) }
      let(:user) { create(:user) }

      it "обнавляет user_id" do
        expect(Cart.get(cart.id, user.id).user_id).to eq user.id
      end

      context 'соединяет две корзины' do
        let(:cart_old) { create(:cart, user_id: user.id) }
        let(:product_1) { create(:product) }
        let(:product_2) { create(:product) }

        before(:each) { cart; cart_old }

        it 'возвращает старую' do
          expect(Cart.get(cart.id, user.id)).to eq cart_old
        end

        it 'удаляет новую' do
          Cart.get(cart.id, user.id)
          expect(Cart.find_by_id(cart.id)).to eq nil
        end

        it 'перемещает заказы в старую' do
          cart.add(product_1.id)
          cart_old.add(product_2.id)
          Cart.get(cart.id, user.id)
          expect(cart_old.items.count).to eq 2
        end

        it "не дублирует заказы" do
          cart.add(product_1.id)
          cart_old.add(product_1.id)
          expect(cart_old.items.count).to eq 1
        end
      end
    end
  end
end
