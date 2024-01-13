import Photo from '../models/Photo';

export type StackParamList = {
  Home: undefined;
  Details: { photo: Photo };
};
