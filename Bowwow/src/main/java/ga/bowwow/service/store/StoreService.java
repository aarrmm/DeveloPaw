package ga.bowwow.service.store;

import java.util.List;

public interface StoreService {

	public void insertProducts(Product products);
	public void updateProducts(Product products);
	public void deleteProducts(Product products);
	public Product getProductDetail(int p_id);
	public List<Product> getProductList(Product product);
	

}
