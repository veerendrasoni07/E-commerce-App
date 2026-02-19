
import 'package:frontend/global_variables.dart';
import 'package:frontend/model/review.dart';
import 'package:frontend/utils/utils.dart';
import 'package:http/http.dart' as http;
class ReviewRatingController{


  Future<void> uploadReviewAndRating({
    required String buyerId,
    required String email,
    required String fullname,
    required String productId,
    required double rating,
    required String review,
    required context
})async{
    try{
      Review ratingReview = Review(
          id: '',
          buyerId: buyerId,
          email: email,
          fullname: fullname,
          productId: productId,
          rating: rating,
          review: review
      );

      http.Response response = await http.post(
          Uri.parse('$uri/api/product-review'),
        body: ratingReview.toJson(),
        headers: <String,String>{
            'Content-Type':'application/json; charset=UTF-8'
        }
      );
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: (){
        showSnackBar(context, "Review is uploaded");
      });
    }catch(e){
      print(e.toString());
      showSnackBar(context, e.toString());
    }
  }
}