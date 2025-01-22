
# Http
**HTTP: (HyperText Transfer Protocol)** 
Rest APi:

- we don't prefer to use pathch in update becosuse it's complacted then put



| HTTP                                       | Rest Api                                        |
| ------------------------------------------ | ----------------------------------------------- |
| way to conmentct bettwen server and client | it heandel the requestbettwen server and client |


![[1703055852267.png]]



**Dependency Injection (DI)** is a design pattern used in software development, particularly in object-oriented programming, to achieve loose coupling between components and improve testability, maintainability, and flexibility. In simple terms, it allows the dependencies of a class (such as services, repositories, or other objects) to be provided from the outside, rather than the class creating those dependencies itself.

service lifetime

| **Transient** | make instance in any service           | بيطنطط في البرنامج                     |
| ------------- | -------------------------------------- | -------------------------------------- |
| **Scoped**    | make new instance only  in new request | التلسكوب كل نظره مكان نختلف في النهايه |
| **Singelton** | just make one instance in lifetime     | سجاده مره وحده في البيت                |

**Middleware** : is software that is assembled into an application pipeline to handle requests and responses. Middleware components are designed to process incoming HTTP requests before they reach the endpoint (like controllers) and also process the outgoing responses before they are sent back to the client.




### Record
why using Record 
-  Immutable(can't changing)
- Reference Types
```c#
//this call position record(Reference Types) are immutable by default ,so you can't update him;
public record persone(int Id,string Name)

//this call struct record(value Types) are mutable by default ,so you can update him;
public record struct persone(int Id, String Name);

//but you can make struct record immutable by add readonly
public readonly record struct persone(int Id, String Name);

```
 
### **Value Types Vs. Reference Types**

| **Category**                   | **Value Types**                                                     | **Reference Types**                                           |
| ------------------------------ | ------------------------------------------------------------------- | ------------------------------------------------------------- |
| **Stored in**                  | Stack(orgnized)ثابت                                                 | Heap(Random)                                                  |
| **Contains**                   | Actual data                                                         | Reference (memory address) to the actual data                 |
| **Default Value**              | Depends on the type (e.g., `int` is `0`, `bool` is `false`)         | `null`                                                        |
| **Memory Allocation**          | Fixed size, allocated on the stack                                  | Variable size, allocated on the heap                          |
| **Examples**                   | `int`, `double`, `bool`, `char`, `struct`, `enum`                   | `class`, `interface`, `array`, `string`, `delegate`, `object` |
| **Copy Behavior**              | When copied, a separate copy of the value is made                   | When copied, only the reference (pointer) is copied           |
| **Nullable**                   | Can use `Nullable<T>` or `T?`                                       | Default value is `null`                                       |
| **Performance**                | Faster due to direct storage on the stack                           | Slower due to dynamic allocation on the heap                  |
| **Examples of Built-in Types** | `int`, `float`, `double`, `decimal`, `bool`, `char`, `byte`, `long` | `string`, `object`, arrays, instances of `class`              |
Additional Notes:
- **Value Types**: 
  - Include all the **simple types** like numeric types (`int`, `double`), `bool`, and **structs**. 
  - They are allocated on the **stack** and are de-allocated when they go out of scope.

- **Reference Types**: 
  - Include **classes**, **arrays**, **strings**, and **interfaces**.
  - The reference (or pointer) to the actual object is stored on the stack, but the object itself is stored on the **heap**. The garbage collector manages memory for reference types.



### Options pattern
1. Enviroment vairables
2. secrets.json
3. appsettings.env.json(the devlopment mode)
4. appsetting.json
``` c#

//make class
namespace SurveyManagementSystem.Api.Authentication;
public class JwtOptions
{
    public string SectionName = "Jwt";
  

    [Required]
    public string Key { get; init; }=string.Empty;

    [Required]
    public string Issuer { get; init; } = string.Empty;

    [Required]
    public string Audience { get; init; } = string.Empty;


    [Range(1,int.MaxValue)]
    public int ExpiryMinutes { get; init; } 
}

//inject in class you want like
public class JwtProvider(IOptions<JwtOptions> options) : IJwtProvider
{
    private readonly JwtOptions _options = options.Value;


    public (string token, int expiresIn) GenerateToken(ApplicationUser user, IEnumerable<string> roles, IEnumerable<string> Permissions)
    {
        Claim[] claims = new Claim[]
        {
            new(JwtRegisteredClaimNames.Sub,user.Id),
            new(JwtRegisteredClaimNames.Email,user.Email!),
            new(JwtRegisteredClaimNames.GivenName,user.FirstName),
            new(JwtRegisteredClaimNames.FamilyName,user.LastName),
            new(JwtRegisteredClaimNames.Jti,Guid.CreateVersion7().ToString()),
            new(nameof(roles),JsonSerializer.Serialize(roles),JsonClaimValueTypes.JsonArray),
            new(nameof(Permissions),JsonSerializer.Serialize(Permissions),JsonClaimValueTypes.JsonArray)
        };

        var symmetricSecurityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_options.Key));

        var signingCredentials = new SigningCredentials(symmetricSecurityKey, SecurityAlgorithms.HmacSha256);

       

        var token = new JwtSecurityToken(
            issuer: "SurveyManagementSystemApp",
            audience: "SurveyManagementSystemApp users",
            claims: claims,
            expires: DateTime.UtcNow.AddMinutes(_options.ExpiryMinutes),
            signingCredentials: signingCredentials
            );

        return (token:new JwtSecurityTokenHandler().WriteToken(token),expiresIn: _options.ExpiryMinutes);


    }   
}
```


### CORS
**CORS**: It's a security stender make the server till the browes if he can send request or not 

Steps in Cors
1. Preflight Request : Http request Ask server if he can send the request
2. Then he return allow or not allow with some data
3. some data be like  Url(https://example.com),Methods(GET, POST) ,....
 
 - the defult cors is  disable  in api 
- you can ignour by use [ignourCors] in endpoint
``` c#
//the cors pirmission be like 
   services.AddCors(options =>
     options.AddDefaultPolicy(builder =>
         builder
.AllowAnyMethod("put","get")
.AllowAnyHeader()                         .WithOrigins(https://drive.google.com)
     )
 );


```

### Logging

| **Log Method**             | **Description**                                                       |
|----------------------------|-----------------------------------------------------------------------|
| `LogTrace`                 | Logs detailed, low-level information for diagnostics.                |
| `LogDebug`                 | Logs debugging information that is useful during development.        |
| `LogInformation`           | Logs general application flow information and significant events.    |
| `LogWarning`               | Logs potentially harmful situations or unexpected events.            |
| `LogError`                 | Logs error events that allow the application to continue running.    |
| `LogCritical`              | Logs very serious errors that require immediate attention.           |
| `LogLogLevel`              | Logs messages based on specified log level, used for filtering.      |
 



### Caching 

| **Caching Type**        | Working Place                                                          | **Best Use Case**                                                  | **Notes**                                                                                                 |
| ----------------------- | ---------------------------------------------------------------------- | ------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------- |
| **Response Caching**    | Front end only                                                         | Reducing server load by caching responses for GET `Ok()` requests. | Reduces network traffic by returning cached responses directly to clients.                                |
| **Output Caching**      | Server only                                                            | Caching controller or Razor page output to improve performance.    | Ideal for static content or pages with limited user-specific content.                                     |
| **In-Memory Caching**   | Works on the memory of the server                                      | Single-server applications for fast, local caching.                | Low latency, but not suitable for distributed environments.                                               |
| **Distributed Caching** | Stores data outside the application server, like **Redis**, SQL Server | Multi-server environments or cloud-based applications.             | Best caching type before .NET 9; enables consistent data sharing across instances.                        |
| **Hybrid Caching**      | Combines in-memory and distributed caching for optimal performance.    | Applications needing fast local access with shared data.           | Includes the advantages of **In-Memory** (speed) and **Distributed** (scalability); introduced in .NET 9. |



### init
`init` accessor allows properties to be set during object initialization, but they become immutable afterward.
```c#
public class Person
{
    public string FirstName { get; init; }
    public string LastName { get; init; }
}

var person = new Person
{
    FirstName = "John",
    LastName = "Doe"
};

//person.FirstName = "Jane"; This will cause a compile-time error.

```


### HealthCheck
```c#
//if you want to check external  api like chatgpt API
Install-Package AspNetCore.HealthChecks.Uris

//Add in DepenincyInjection
.AddUrlGroup(name: "external api",uri:new(https://chatgpt.com));
 services.AddHealthChecks()
     .AddSqlServer(name: "database", connectionString: connectionString!)
     .AddHangfire(options => { options.MinimumAvailableServers = 1; })
     .AddUrlGroup(name: "external api",uri:new(https://chatgpt.com));
     .AddCheck<MailProviderHealthCheck>(name: "mail service");

//Custom Healthcheck 
//exemple
											   
namespace SurveyBasket.Health;
public class MailProviderHealthCheck(IOptions<MailSettings> mailSettings) : IHealthCheck
{
    private readonly MailSettings _mailSettings = mailSettings.Value;

    public async Task<HealthCheckResult> CheckHealthAsync(HealthCheckContext context, CancellationToken cancellationToken = default)
    {
        try
        {
            using var smtp = new SmtpClient();
            
            smtp.Connect(_mailSettings.Host, _mailSettings.Port, SecureSocketOptions.StartTls, cancellationToken);
            smtp.Authenticate(_mailSettings.Mail, _mailSettings.Password, cancellationToken);

            return await Task.FromResult(HealthCheckResult.Healthy());
        }
        catch (Exception exception)
        {
            return await Task.FromResult(HealthCheckResult.Unhealthy(exception: exception));
        }
    }
}
```

### RateLimiting

| **Algorithm**      | **Description**                                                                                          | **Example**                                                                                           |
| ------------------ | --------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- |
| **Token Bucket**   | Controls data flow by allowing a set number of requests (tokens) to be processed in a given time frame. | A network can send bursts of data but is limited to a steady flow over time, allowing 100 tokens per second. |
| **Concurrency**    | Functions like a queue: one request comes in as another goes out.                                       | A restaurant seating 10 customers at a time; as one leaves, another can enter.                       |
| **Fixed Window**   | Limits requests to a fixed number (e.g., 200 requests per minute); useful for managing capacity.       | A classroom can admit 30 students at a time; once full, no more can enter until the next session.   |
| **Sliding Window** | Provides more precise control by tracking requests over the last X seconds/minutes for better granularity.| A website allows 5 requests every minute; if 3 requests come in during the first minute, 2 remain for the next minute. |

```c#
//form .net 7 RateLimiting was builtin in .net

//Concurrency
rateLimiterOptions.AddConcurrencyLimiter(RateLimiters.Concurrency, options =>
{
      options.PermitLimit = 1000;
      options.QueueLimit = 100;
      options.QueueProcessingOrder = QueueProcessingOrder.OldestFirst;
  });


//Token Bucket
rateLimiterOptions.AddTokenBucketLimiter("token", options =>
{
    options.TokenLimit = 2;
    options.QueueLimit = 1;
    options.QueueProcessingOrder = QueueProcessingOrder.OldestFirst;
    options.ReplenishmentPeriod = TimeSpan.FromSeconds(30);
    options.TokensPerPeriod = 2;
    options.AutoReplenishment = true;
});

//Fixed Window
rateLimiterOptions.AddFixedWindowLimiter("fixed", options =>
{
    options.PermitLimit = 2;
    options.Window = TimeSpan.FromSeconds(20);
    options.QueueLimit = 1;
    options.QueueProcessingOrder = QueueProcessingOrder.OldestFirst;
});

//Sliding Window
rateLimiterOptions.AddSlidingWindowLimiter("sliding", options =>
{
    options.PermitLimit = 2;
    options.Window = TimeSpan.FromSeconds(20);
    options.SegmentsPerWindow = 2;
    options.QueueLimit = 1;
    options.QueueProcessingOrder = QueueProcessingOrder.OldestFirst;
});


//if you have i user send i alot of request and you want to handel him useing Police
    private static IServiceCollection AddRateLimitingConfig(this IServiceCollection services)
    {
        services.AddRateLimiter(rateLimiterOptions =>
        {
            rateLimiterOptions.RejectionStatusCode = StatusCodes.Status429TooManyRequests;

            rateLimiterOptions.AddPolicy(RateLimiters.IpLimiter, httpContext =>
                RateLimitPartition.GetFixedWindowLimiter(
                    partitionKey: httpContext.Connection.RemoteIpAddress?.ToString(),
                    factory: _ => new FixedWindowRateLimiterOptions
                    {
                        PermitLimit = 2,
                        Window = TimeSpan.FromSeconds(20)
                    }
            )
            );

            rateLimiterOptions.AddPolicy(RateLimiters.UserLimiter, httpContext =>
                RateLimitPartition.GetFixedWindowLimiter(
                    partitionKey: httpContext.User.GetUserId(),
                    factory: _ => new FixedWindowRateLimiterOptions
                    {
                        PermitLimit = 2,
                        Window = TimeSpan.FromSeconds(20)
                    }
            )
            );
    }

//Useing it like to put attribute
[Route("[controller]")]
[ApiController]								[EnableRateLimiting(RateLimiters.IpLimiter)]
public class AuthController(IAuthService authService, ILogger<AuthController> logger) : ControllerBase
{
}

//If you have i use put you want to make limit requests you can do
   
   rateLimiterOptions.AddPolicy(RateLimiters.UserLimiter, httpContext =>
       RateLimitPartition.GetFixedWindowLimiter(
           partitionKey: httpContext.User.GetUserId(),
           factory: _ => new FixedWindowRateLimiterOptions
           {
               PermitLimit = 2,
               Window = TimeSpan.FromSeconds(20)
           }
   )
   );								
//then use attribute							[EnableRateLimiting(RateLimiters.UserLimiter)]

```

# Questions
- why we use interface the question in 3/8
- the diff bettwen role permission

