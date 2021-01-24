package market;

public class ShopDTO {
	
	//상품관리
	private int idx; //상품일련변호(장바구니 호환)
	private String image;//상품이미지
	private String product_name;//상품명
	private int price;//가격
	private int saved_money;//적립금
	private String manual;//상품설명
	//장바구니
	private String id; //주문 고객아이디
	private int count; //주문갯수
	private int sum; //총합
	private String payResult; //결제상황(y,n)
	//상품주문
	private String product_data;
	private String user_data;
	private String shop_address;
	private String pay_type;
	//결제시간도 넣어주면 좋겠다
	
	//getter/setter 생성
	public String getPayResult() {
		return payResult;
	}
	public void setPayResult(String payResult) {
		this.payResult = payResult;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getSaved_money() {
		return saved_money;
	}
	public void setSaved_money(int saved_money) {
		this.saved_money = saved_money;
	}
	public String getManual() {
		return manual;
	}
	public void setManual(String manual) {
		this.manual = manual;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getSum() {
		return sum;
	}
	public void setSum(int sum) {
		this.sum = sum;
	}
	public String getProduct_data() {
		return product_data;
	}
	public void setProduct_data(String product_data) {
		this.product_data = product_data;
	}
	public String getUser_data() {
		return user_data;
	}
	public void setUser_data(String user_data) {
		this.user_data = user_data;
	}
	public String getShop_address() {
		return shop_address;
	}
	public void setShop_address(String shop_address) {
		this.shop_address = shop_address;
	}
	public String getPay_type() {
		return pay_type;
	}
	public void setPay_type(String pay_type) {
		this.pay_type = pay_type;
	}	
}
