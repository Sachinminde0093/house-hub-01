
import 'package:fpdart/fpdart.dart';
import 'package:house_hub/core/failure.dart';

typedef FutureEather<T> = Future<Either<Failure, T>>;

typedef FutureVoid = FutureEather<void>;
