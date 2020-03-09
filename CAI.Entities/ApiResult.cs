namespace CAI.Entities
{
    public class ApiResult<T>
    {
        public T Data { get; set; }
        public int ErrorCode { get; set; }
        public string Message { get; set; }
    }
}
