package ga.bowwow.service.store.impl;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ga.bowwow.service.store.CartList;
import ga.bowwow.service.store.Order;
import ga.bowwow.service.store.OrderDTO;
import ga.bowwow.service.store.OrderDetail;
import ga.bowwow.service.store.Product;
import ga.bowwow.service.store.Review;

@Repository("storeDAO")
public class StoreDAO {

	@Autowired
	private SqlSessionTemplate mybatis;

	public StoreDAO() {
		System.out.println(">> StoreDAO 객체 생성");
	}

	// 상품 관련 dao

	public Product getProductDetail(int p_id) {
	    return mybatis.selectOne("Store.getProductDetail", p_id);
	}

	public List<Product> getProductList(Map<String, String> map) {
		return mybatis.selectList("Store.ProductList", map);
	}

	public int getProductCount(Map<String, String> map) {
		return mybatis.selectOne("Store.ProductCount", map);
	}
	public List<Product> getDogProductByPrice(Product products) {
		return mybatis.selectList("Store.getDogProductByPrice", products);
	}

	public List<Product> getCatProductByPrice(Product products) {
		return mybatis.selectList("Store.getCatProductByPrice", products);
	}
	
	public int getSearchCount(Map<String, String> map) {
		return mybatis.selectOne("Store.ProductSearchCount", map);
	}

	public List<Product> searchProd(Map<String, String> map) {
		return mybatis.selectList("Store.searchProd", map);
	}


	// 장바구니 관련 dao

	// 장바구니 추가
	public void addCart(CartList cartList) {
		mybatis.insert("Cart.addCart", cartList);
	}

	// 장바구니 목록 조회
	public List<CartList> getCartList(String id) {
		return mybatis.selectList("Cart.getCartList", id);
	}

	// 장바구니 동일한 제품 있는지 조회
	public int cartCheck(CartList cartList) {
		return mybatis.selectOne("Cart.cartCheck", cartList);

	}

	// 장바구니 상품 갯수 수정
	public int updateCart(CartList cartList) {
		return mybatis.update("Cart.updateCart", cartList);
	}

	// 장바구니 상품 삭제
	public int deleteCart(CartList cartList) {
		return mybatis.delete("Cart.deleteCart", cartList);
	}
	
	// 장바구니 상품 전체 삭제
	public void deleteCartAll(String id) {
		mybatis.delete("Cart.deleteCartAll", id);
	}
	
	// 장바구니 상품 삭제2
	public int OrderDelCart(Order Order) {
		return mybatis.delete("Cart.OrderDelCart", Order);
	}

	// 상품 후기 dao
	public int insertReview(Review review) {
		System.out.println("후기 등록 : " + review);
		return mybatis.insert("StoreReview.insertProductReview", review);
	}

	public void deleteReview(int review_id) {
		System.out.println("후기 삭제" + review_id);
		mybatis.delete("StoreReview.deleteProductReview", review_id);
	}

	public Review getLastReview(int p_id) {
		System.out.println("가장 마지막에 작성한 후기 가져오기");
		return mybatis.selectOne("StoreReview.getLastReview", p_id);
	}

	public List<Review> getReviewList(int p_id) {
		System.out.println("상품에 작성된 후기 목록 출력");
		return mybatis.selectList("StoreReview.reviewList", p_id);
	}

	// 상품 주문 dao
	public int insertOrder(Order order) {
		System.out.println("주문내역 추가 : " + order);
		return mybatis.insert("StoreOrder.insertOrder", order);
	}

	public void deleteOrder(String order_id) {
		System.out.println("삭제할 주문내역 : " + order_id);
		mybatis.delete("StoreOrder.deleteOrder", order_id);
	}

	public List<Order> getOrderList(Order order) {
		System.out.println("회원 주문 내역 리스트 : " + order);
		return mybatis.selectList("StoreOrder.orderList", order);
	}

	public Order getOrderDetail(int order_id) {
		System.out.println("주문 상세 내역 : " + order_id);
		return mybatis.selectOne("StoreOrder.orderDetail", order_id);
	}

	public void changeStock(Order order) {
		mybatis.update("StoreOrder.changeStock",order);
	}

	public void changeOrderStatus(int order_id) {
		mybatis.update("StoreOrder.changeOrderStatus",order_id);
	}

	public void insertOrderDetail(OrderDetail orderDetail) {
		mybatis.insert("StoreOrder.insertOrderDetail", orderDetail);
	}

	public List<Order> orderFromCartList(int order_id) {
		return mybatis.selectList("StoreOrder.orderFromCartList", order_id);
	}


}
