enum StatusFetchData {
  initial,
  fetching,
  fetched,
  error;

  get isInitial => this == StatusFetchData.initial;

  get isCompleted => this == StatusFetchData.fetched;

  get isLoading => this == StatusFetchData.fetching;

  get isError => this == StatusFetchData.error;
}