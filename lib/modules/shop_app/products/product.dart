import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/lauout/shoping_app/cubit/shopCubit.dart';
import 'package:shop_app/lauout/shoping_app/cubit/shopState.dart';
import 'package:shop_app/models/shop_app/categories_model.dart';
import 'package:shop_app/models/shop_app/home_model.dart';
import 'package:shop_app/shared/Components/component.dart';
import 'package:shop_app/shared/Styles/Colors.dart';

class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessFavouriteDataState) {
          if (!state.model.status) {
            showToast(state: ToastState.ERROR, text: state.model.message);
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoriesModel != null,
          builder: (context) =>
              productBuilder(cubit.homeModel, cubit.categoriesModel, context),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productBuilder(
      HomeModel model, CategoriesModel categoriesModel, context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: [
              Image(
                image: NetworkImage(
                    'https://www.xda-developers.com/files/2021/04/Microsoft-Surface-Laptop-4-product-image-3.jpg'),
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Image(
                image: NetworkImage(
                    'https://www.91-img.com/pictures/television/xiaomi/xiaomi-mi-tv-4a-horizon-140082-large-1.jpg?tr=q-60'),
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Image(
                image: NetworkImage(
                    'https://cdn.mos.cms.futurecdn.net/wit7CApXGmn52HdGKGW5t3-1200-80.jpg'),
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Image(
                image: NetworkImage(
                    'https://st1.bgr.in/wp-content/uploads/2021/02/top-5-iphone-13.jpg'),
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Image(
                image: NetworkImage(
                    'https://www.xda-developers.com/files/2020/10/top-tech-deals-airpods-pro-header.jpg'),
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ],
            /*model.data.banners.map((element) {
              return Image(
                image: NetworkImage('${element.image}'),
                width: double.infinity,
                fit: BoxFit.cover,
              );
            }).toList(),*/
            options: CarouselOptions(
                height: 250.0,
                initialPage: 0,
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(milliseconds: 3000),
                autoPlayAnimationDuration: Duration(milliseconds: 1000),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 100.0,
                  child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          buildCategoriesItem(categoriesModel.data.data[index]),
                      separatorBuilder: (context, index) => SizedBox(
                            width: 10.0,
                          ),
                      itemCount: categoriesModel.data.data.length),
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  'New Products',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontWeight: FontWeight.w800, fontSize: 24),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 3,
              mainAxisSpacing: 3,
              childAspectRatio: 1 / 1.76,
              children: List.generate(
                model.data.products.length,
                (index) =>
                    buildGridProduct(model.data.products[index], context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGridProduct(ProductModel model, context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: double.infinity,
                  height: 200.0,
                ),
                if (model.discount != 0)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    color: Colors.red,
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      height: 1.3,
                      fontSize: 16.0,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price}',
                        style: TextStyle(
                            fontSize: 16.0,
                            color: defaultColor,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice}',
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      Spacer(),
                      IconButton(
                        icon: CircleAvatar(
                          backgroundColor:
                              ShopCubit.get(context).favourites[model.id]
                                  ? defaultColor
                                  : Colors.grey,
                          radius: 15.0,
                          child: Icon(
                            Icons.favorite_border,
                            size: 14.0,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          ShopCubit.get(context).postChangeFavourite(model.id);
                        },
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      );

  Widget buildCategoriesItem(DataModel model) => Container(
        color: Colors.white,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image(
              image: NetworkImage(model.image),
              width: 100.0,
              height: 100.0,
              fit: BoxFit.cover,
            ),
            Container(
              color: Colors.black.withOpacity(0.88),
              width: 100,
              child: Text(
                model.name,
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            )
          ],
        ),
      );
}
