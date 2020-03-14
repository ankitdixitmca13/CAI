using System.Data;

namespace CAI.Repository.Contracts
{
    public interface IBaseConnectionFactory
    {
        IDbConnection GetConnection { get; }
        void CloseConnection();
    }
}
