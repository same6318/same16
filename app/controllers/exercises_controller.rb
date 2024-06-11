class ExercisesController < ApplicationController
  def exercise1
    # 【要件】注文されていないすべての料理を返すこと
    #   * left_outer_joinsを使うこと
    @foods = Food.left_outer_joins(:orders).where(orders: {id:nil})
  end

  def exercise2
    # 【要件】注文されていない料理を提供しているすべてのお店を返すこと
    #   * left_outer_joinsを使うこと
    @shops = Shop.left_outer_joins(:foods).select(:name).distinct #重複を消す
  end

  def exercise3 
    # 【要件】配達先の一番多い住所を返すこと
    #   * joinsを使うこと
    #   * 取得したAddressのインスタンスにorders_countと呼びかけると注文の数を返すこと
    @address = Address.joins(:orders).group("city").select("COUNT(city) as orders_count, city").order("orders_count DESC").first
    #1.配達先であるcityをグループ化する
    #2.select文でaddressesテーブルのcityカラムを選択して、sql関数であるCOUNTを実行、cityカラムのnullじゃないものを数える。as orders_countとして名前変更している。
    #3.order文でorders_countを「DESC」降順表示する
    #4.map関数で受け取ったものを|d|として変数に入れて、d.oreders_countとd.cityでオーダー回数とcityの名前を取り出して配列として作成している。
  end

  def exercise4 
    # 【要件】一番お金を使っている顧客を返すこと
    #   * joinsを使うこと
    #   * 取得したCustomerのインスタンスにfoods_price_sumと呼びかけると合計金額を返すこと
    @customer = Customer.joins(orders: :foods).group("customers.id").select("SUM(foods.price) as foods_price_sum, customers.id").order("foods_price_sum DESC").first #ここからfoodsのpriceカラムを抽出するwhereを書きたい。

  end
end
