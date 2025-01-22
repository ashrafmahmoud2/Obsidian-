
# Install-Package Telegram.BotAPI

#### Add Dependencs
``` c#

```

#### Mapping 
``` c# 
//dwenlode packges
mapster,Mapster.DependencyInjection

//add in pipline or DependencyInjection.cs
 private static IServiceCollection AddMapsterConfig(this         IServiceCollection services)
    {
        var mappingConfig = TypeAdapterConfig.GlobalSettings;
        mappingConfig.Scan(Assembly.GetExecutingAssembly());

        services.AddSingleton<IMapper>(new Mapper(mappingConfig));

        return services;
    }

//make global class in folder mapping 
public class MappingConfigurations : IRegister
{
    public void Register(TypeAdapterConfig config)
    {
        config.NewConfig<QuestionRequest, Question>()
            .Map(dest => dest.Answers, src => src.Answers.Select(answer => new Answer { Content = answer }));

        config.NewConfig<RegisterRequest, ApplicationUser>()
            .Map(dest => dest.UserName, src => src.Email);

    
    }
}

push in githup
```


#### FluentValidation 
``` c# 
//dwenlode packges
FluentValidation.DependencyInjectionExtensions
FluentValidation.AspNetCore

//add in pipline or DependencyInjection.cs
 private static IServiceCollection AddFluentValidationConfig(this IServiceCollection services)
    {
        services
            .AddFluentValidationAutoValidation()
            .AddValidatorsFromAssembly(Assembly.GetExecutingAssembly());

        return services;
    }

// crate folder Contracts/Polls (pollrequest.cs,pollrequestValidator.cs)


namespace SurveyManagementSystem.Api.Contracts.Polls;
public class PollRequestValidator : AbstractValidator<PollRequest>
{
    public PollRequestValidator()
    {
        //RuleFor(x => x.Email)
        //    .NotEmpty()
        //    .EmailAddress();

        //RuleFor(x => x.FirstName)
        //    .NotEmpty()
        //    .Length(3, 100);

        //RuleFor(x => x.LastName)
        //    .NotEmpty()
        //    .Length(3, 100);

        //RuleFor(x => x.Roles)
        //    .NotNull()
        //    .NotEmpty();

        //RuleFor(x => x.Roles)
        //    .Must(x => x.Distinct().Count() == x.Count)
        //    .WithMessage("You cannot add duplicated role for the same user")
        //    .When(x => x.Roles != null);
    }
}


push in githup
```


#### Ef core 
``` c# 
//dwenlode packges
 Install-Package Microsoft.EntityFrameworkCore
 Install-PackageMicrosoft.EntityFrameworkCore.Tools
 Install-Package Microsoft.EntityFrameworkCore.SqlServer

//add Persistence folder to put any thing about data
//but migrations file in Persistence folder

//appsetting
  "DefaultConnection": "Server=(localdb)\\ProjectModels;Database=SurveyBasket2;Trusted_Connection=True;Encrypt=False",

//add configration in program or in addDependencs
	 var connectionString = configuration.GetConnectionString("DefaultConnection") ??
            throw new InvalidOperationException("Connection string 'DefaultConnection' not found.");

        services.AddDbContext<ApplicationDbContext>(options =>
            options.UseSqlServer(connectionString));



//add ApplicationDbContext
public class ApplicationDbContext(DbContextOptions<ApplicationDbContext> options, IHttpContextAccessor httpContextAccessor) :
    IdentityDbContext<ApplicationUser, ApplicationRole, string>(options)
{
    private readonly IHttpContextAccessor _httpContextAccessor = httpContextAccessor;

    public DbSet<Answer> Answers { get; set; }
    public DbSet<Poll> Polls { get; set; }
    

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.ApplyConfigurationsFromAssembly(Assembly.GetExecutingAssembly());

        var cascadeFKs = modelBuilder.Model
                .GetEntityTypes()
                .SelectMany(t => t.GetForeignKeys())
                .Where(fk => fk.DeleteBehavior == DeleteBehavior.Cascade && !fk.IsOwnership);

        foreach (var fk in cascadeFKs)
            fk.DeleteBehavior = DeleteBehavior.Restrict;

        base.OnModelCreating(modelBuilder);
    }
//it's to handel the add and update user info
    public override Task<int> SaveChangesAsync(CancellationToken cancellationToken = default)
    {
        var entries = ChangeTracker.Entries<AuditableEntity>();

        foreach (var entityEntry in entries)
        {
            var currentUserId = _httpContextAccessor.HttpContext?.User.GetUserId()!;

            if (entityEntry.State == EntityState.Added)
            {
                entityEntry.Property(x => x.CreatedById).CurrentValue = currentUserId;
            }
            else if (entityEntry.State == EntityState.Modified)
            {
                entityEntry.Property(x => x.UpdatedById).CurrentValue = currentUserId;
                entityEntry.Property(x => x.UpdatedOn).CurrentValue = DateTime.UtcNow;
            }
        }

        return base.SaveChangesAsync(cancellationToken);
    }
}


// add Configurations of Database in migration ,in folder Persistence.EntitiesConfigurations be like 
namespace SurveyManagementSystem.Api.Persistence.EntitiesConfigurations;
public class PollConfiguration : IEntityTypeConfiguration<Poll>
{
    public void Configure(EntityTypeBuilder<Poll> builder)
    {
        //builder.HasIndex(x => new { x.QuestionId, x.Content }).IsUnique();

        //builder.Property(x => x.Content).HasMaxLength(1000);
    }
}





push in githup

```

#### Add services
``` c#
//make interface and implmention like:

//interface
public interface IPollService
{
    Task<IEnumerable<PollResponse>> GetAllAsync(CancellationToken cancellationToken = default);
    Task<IEnumerable<PollResponse>> GetCurrentAsyncV1(CancellationToken cancellationToken = default);
    Task<IEnumerable<PollResponseV2>> GetCurrentAsyncV2(CancellationToken cancellationToken = default);
    Task<Result<PollResponse>> GetAsync(int id, CancellationToken cancellationToken = default);
    Task<Result<PollResponse>> AddAsync(PollRequest request, CancellationToken cancellationToken = default);
    Task<Result> UpdateAsync(int id, PollRequest request, CancellationToken cancellationToken = default);
    Task<Result> DeleteAsync(int id, CancellationToken cancellationToken = default);
    Task<Result> TogglePublishStatusAsync(int id, CancellationToken cancellationToken = default);
}




//implumantion
public class PollService(ApplicationDbContext context, INotificationService notificationService) : IPollService
{
    private readonly ApplicationDbContext _context = context;
    private readonly INotificationService _notificationService = notificationService;

    public async Task<IEnumerable<PollResponse>> GetAllAsync(CancellationToken cancellationToken = default) =>
        await _context.Polls
            .AsNoTracking()
            .ProjectToType<PollResponse>()
            .ToListAsync(cancellationToken);

    public async Task<IEnumerable<PollResponse>> GetCurrentAsyncV1(CancellationToken cancellationToken = default) =>
        await _context.Polls
            .Where(x => x.IsPublished && x.StartsAt <= DateOnly.FromDateTime(DateTime.UtcNow) && x.EndsAt >= DateOnly.FromDateTime(DateTime.UtcNow))
            .AsNoTracking()
            .ProjectToType<PollResponse>()
            .ToListAsync(cancellationToken);

    public async Task<IEnumerable<PollResponseV2>> GetCurrentAsyncV2(CancellationToken cancellationToken = default) =>
        await _context.Polls
            .Where(x => x.IsPublished && x.StartsAt <= DateOnly.FromDateTime(DateTime.UtcNow) && x.EndsAt >= DateOnly.FromDateTime(DateTime.UtcNow))
            .AsNoTracking()
            .ProjectToType<PollResponseV2>()
            .ToListAsync(cancellationToken);

    public async Task<Result<PollResponse>> GetAsync(int id, CancellationToken cancellationToken = default)
    {
        var poll = await _context.Polls.FindAsync(id, cancellationToken);

        return poll is not null
            ? Result.Success(poll.Adapt<PollResponse>())
            : Result.Failure<PollResponse>(PollErrors.PollNotFound);
    }

    public async Task<Result<PollResponse>> AddAsync(PollRequest request, CancellationToken cancellationToken = default)
    {
        var isExistingTitle = await _context.Polls.AnyAsync(x => x.Title == request.Title, cancellationToken: cancellationToken);

        if (isExistingTitle)
            return Result.Failure<PollResponse>(PollErrors.DuplicatedPollTitle);

        var poll = request.Adapt<Poll>();

        await _context.AddAsync(poll, cancellationToken);
        await _context.SaveChangesAsync(cancellationToken);

        return Result.Success(poll.Adapt<PollResponse>());
    }

    public async Task<Result> UpdateAsync(int id, PollRequest request, CancellationToken cancellationToken = default)
    {
        var isExistingTitle = await _context.Polls.AnyAsync(x => x.Title == request.Title && x.Id != id, cancellationToken: cancellationToken);

        if (isExistingTitle)
            return Result.Failure<PollResponse>(PollErrors.DuplicatedPollTitle);

        var currentPoll = await _context.Polls.FindAsync(id, cancellationToken);

        if (currentPoll is null)
            return Result.Failure(PollErrors.PollNotFound);

        currentPoll = request.Adapt(currentPoll);

        await _context.SaveChangesAsync(cancellationToken);

        return Result.Success();
    }

    public async Task<Result> DeleteAsync(int id, CancellationToken cancellationToken = default)
    {
        var poll = await GetAsync(id, cancellationToken);

        if (poll is null)
            return Result.Failure(PollErrors.PollNotFound);

            _context.Remove(poll);

        await _context.SaveChangesAsync(cancellationToken);

        return Result.Success();
    }

    public async Task<Result> TogglePublishStatusAsync(int id, CancellationToken cancellationToken = default)
    {
        var poll = await _context.Polls.FindAsync(id, cancellationToken);

        if (poll is null)
            return Result.Failure(PollErrors.PollNotFound);

        poll.IsPublished = !poll.IsPublished;

        await _context.SaveChangesAsync(cancellationToken);

        if (poll.IsPublished && poll.StartsAt == DateOnly.FromDateTime(DateTime.UtcNow))
            BackgroundJob.Enqueue(() => _notificationService.SendNewPollsNotification(poll.Id));

        return Result.Success();
    }
}


push in githup
```

#### Authorization ,Identity,
```  c#
// create ApplicationUser
﻿namespace SurveyBasket.Entities;
public sealed class ApplicationUser : IdentityUser
{
    public ApplicationUser()
    {
        Id = Guid.CreateVersion7().ToString();
        SecurityStamp = Guid.CreateVersion7().ToString();
    }

    public string FirstName { get; set; } = string.Empty;
    public string LastName { get; set; } = string.Empty;
    public bool IsDisabled { get; set; }

    public List<RefreshToken> RefreshTokens { get; set; } = [];
}

//create ApplicationRole
﻿namespace SurveyBasket.Entities;
public class ApplicationRole : IdentityRole
{
    public ApplicationRole()
    {
        Id = Guid.CreateVersion7().ToString();
    }

    public bool IsDefault { get; set; }
    public bool IsDeleted { get; set; }
}

//create AuditableEntity
 namespace SurveyBasket.Entities;
public class AuditableEntity
{
    public string CreatedById { get; set; } = string.Empty;
    public DateTime CreatedOn { get; set; } = DateTime.UtcNow;
    public string? UpdatedById { get; set; }
    public DateTime? UpdatedOn { get; set; }

    public ApplicationUser CreatedBy { get; set; } = default!;
    public ApplicationUser? UpdatedBy { get; set; }
}

//add AuditableEntity in Entities class to add user info in table in db like,if you need :
public sealed class Poll : AuditableEntity
{
    public int Id { get; set; }
    public string Title { get; set; } = string.Empty; 
}




//add IdentityDbContext in ApplctionBdContext  construtor
 IdentityDbContext<ApplicationUser, ApplicationRole, string>


notes:
.we use ApplicationUser not IdenityUser becouse whene we want to make update make on ApplicationUser then he inhrt from Idenity USER

push in githup
```

### CORS
``` C#

// Add this code in DependincyInjection
public static IServiceCollection AddCorsConfig(this IServiceCollection services, IConfiguration configuration)
        {
            services.AddCors(options =>
              options.AddDefaultPolicy(builder =>
               builder
                   .AllowAnyMethod()
                   .AllowAnyHeader()
                   .WithOrigins(configuration.GetSection("AllowedOrigins").Get<string[]>()!)));

            return services;
        }


// Add in middleware before UseAuthorization
app.UseCors();
app.UseAuthorization();
```

### JWT
``` C#
//install package 
Microsoft.AspNetCore.Authentication.JwtBearer

//add AuthResponse

//add loginresponse,with validator ,with RegexPatterns

//add IAuthServices

//add AuthServices

//add in DependencyInjection
 private static IServiceCollection AddAuthConfig(this IServiceCollection services)
   {
       
       services.AddSingleton<IJwtProvider, JwtProvider>();
       services.AddIdentity<ApplicationUser, ApplicationRole>()
           .AddEntityFrameworkStores<ApplicationDbContext>();


       return services;
   }

//add IJwtProvider,JwtProvider with inject in DependencyInjection

//add options pattert

//add 
```

### Options Pattern
``` c#
//Add the class you want
public class EmailSettings
{

    public const string SectionName = "Mailjet"; 
    [Required] public string ApiKey { get; set; } = string.Empty;
    [Required] public string SecretKey { get; set; } = string.Empty;
    [Required] public string SenderEmail { get; set; } = string.Empty;
    [Required] public string SenderName { get; set; } = string.Empty;
}


//Add in Dipancyinjection with Data
 services.AddScoped<IEmailService, EmailService>();
   services.AddOptions<EmailSettings>()
     .Bind(configuration.GetSection("Mailjet"))
     .ValidateDataAnnotations()
     .ValidateOnStart();


//in the service 
public class EmailService : IEmailService
{
    // Using in email Api https://app.mailjet.com/account/apikeys

    private readonly EmailSettings _emailSettings;

    public EmailService(IOptions<EmailSettings> options)
    {
        _emailSettings = options.Value;
    }

    public async Task SendEmailAsync(string toEmail, string subject, string body)
    {
        var client = new MailjetClient(_emailSettings.ApiKey, _emailSettings.SecretKey);

        var request = new MailjetRequest
        {
            Resource = Send.Resource,
        }
        .Property(Send.FromEmail, _emailSettings.SenderEmail)
        .Property(Send.FromName, _emailSettings.SenderName)
        .Property(Send.Subject, subject)
        .Property(Send.HtmlPart, body)
        .Property(Send.Recipients, new JArray {
            new JObject { { "Email", toEmail } }
        });

        var response = await client.PostAsync(request);

        if (response.IsSuccessStatusCode)
        {
            Console.WriteLine("Email sent successfully.");
        }
        else
        {
            Console.WriteLine($"Error sending email: {response.StatusCode}\n{response.GetData()}");
        }
    }
}


//In appsettings 
"Mailjet": {
  "ApiKey": "",
  "SecretKey": "",
  "SenderEmail": "mmoo19701@gmail.com",
  "SenderName": "Dev/Ashraf"
}

```
### ExceptionHandler
```c# 
using Microsoft.AspNetCore.Diagnostics;
namespace SurveyManagementSystem.Api.Errors;
public class GlobalExceptionHandler(ILogger<GlobalExceptionHandler> logger) : IExceptionHandler
{
    private readonly ILogger<GlobalExceptionHandler> _logger = logger;



    // IExceptionHandler from .net 8 

    public async ValueTask<bool> TryHandleAsync(HttpContext httpContext, Exception exception, CancellationToken cancellationToken)
    {
        _logger.LogError(exception, "Something went wrong: {Message}", exception.Message);

        var problemDetails = new ProblemDetails
        {
            Status = StatusCodes.Status500InternalServerError,
            Title = "Internal Server Error",
            Type = "https://datatracker.ietf.org/doc/html/rfc7231#section-6.6.1"
        };

        httpContext.Response.StatusCode = StatusCodes.Status500InternalServerError;

        await httpContext.Response.WriteAsJsonAsync(problemDetails, cancellationToken: cancellationToken);

        return true;
    }
}

// add in middleware
app.UseExceptionHandler();

//Add in DependincyInjection
 services.AddExceptionHandler<GlobalExceptionHandler>();
 services.AddProblemDetails();

```













### Logging

```c#
//Add Package
Serilog
Serilog.AspNetCore

//Add in prgrogrm
builder.Host.UseSerilog((context, configuration) =>
    configuration.ReadFrom.Configuration(context.Configuration)
);
var app = builder.Build();
//Delete Logging from appsetting the put 
//in appsettings.Development.json
{
  "Serilog": {
    "MinimumLevel": {
      "Default": "Information",
      "Override": {
        "Microsoft.AspNetCore": "Warning"
      }
    },
    "WriteTo": [
      {
        "Name": "Console"
      } //,
      //{
      //  "Name": "File",
      //  "Args": {
      //    "path": "D:\\Logs\\log-.txt",
      //    "rollingInterval": "Day",
      //    "formatter": "Serilog.Formatting.Json.JsonFormatter"
      //  }
      //}
    ],
    "Enrich": [ "FromLogContext", "WithMachineName", "WithThreadId" ],
    "Properties": {
      "ApplicationName": "SurveyBasket"
    }
  },
  "AllowedOrigins": [
    "https://localhost:7064"
  ]
}
//in appsettings.json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=(localdb)\\MSSQLLocalDB;Database=SurveyManagementSystem;Trusted_Connection=True;Encrypt=False"
  },
  "Serilog": {
    "MinimumLevel": {
      "Default": "Information",
      "Override": {
        "Microsoft.AspNetCore": "Warning",
        "Hangfire": "Information"
      }
    },
    "WriteTo": [
      {
        "Name": "Console"
      }
      // {
      //   "Name": "File",
      //   "Args": {
      //     "path": "D:\\Logs\\log-.txt",
      //     "rollingInterval": "Day",
      //     "formatter": "Serilog.Formatting.Compact.CompactJsonFormatter, Serilog.Formatting.Compact"
      //   }
      // }
    ],
    "Enrich": [
      "FromLogContext",
      "WithMachineName",
      "WithThreadId"
    ],
    "Properties": {
      "ApplicationName": "SurveyBasket"
    }
  },
  "AllowedHosts": "*",
  "JWT": {
    "Key": "",
    "Issuer": "SurveyManagementSystemApp",
    "Audience": "SurveyManagementSystemApp users",
    "ExpiryMinutes": 30
  },
  "AllowedOrigins": [
    "https://www.survey-basket.com"
  ]
}

//it better to right like it to give Email and password difrrent colore
_logger.LogInformation("Logging with email: {email} and password: {password}", request.Email, request.Password);
//not like 
        _logger.LogInformation("Logging with email: {request.Email} and password: {request.Password}");


```
### Cacheing
```c#
//We Will use Hybrid Cache start from .net 9
Microsoft.Extensions.Caching.Hybrid

//add in DependencyInjection with warning disable if return error
#pragma warning disable // Suppressing all warnings temporarily
        services.AddHybridCache();
#pragma warning restore // Re-enabling warnings

//inject in ctor
HybridCache hybridCache

//add Cach
private const string _cachePrefix = "availableQuestions";

public async Task<Result<IEnumerable<QuestionResponse>>> GetAvailableAsync(int pollId, string userId, CancellationToken cancellationToken = default)
   {
       var hasVote = await _context.Votes.AnyAsync(x => x.PollId == pollId && x.UserId == userId, cancellationToken);

       if (hasVote)
           return Result.Failure<IEnumerable<QuestionResponse>>(VoteErrors.DuplicatedVote);

       var pollIsExists = await _context.Polls.AnyAsync(x => x.Id == pollId && x.IsPublished
       && x.StartsAt <= DateOnly.FromDateTime(DateTime.UtcNow) &&
       x.EndsAt >= DateOnly.FromDateTime(DateTime.UtcNow),
       cancellationToken);

       if (!pollIsExists)
           return Result.Failure<IEnumerable<QuestionResponse>>(PollErrors.PollNotFound);

       var cacheKey = $"{_cachePrefix}-{pollId}";

       var questions = await _hybridCache.GetOrCreateAsync<IEnumerable<QuestionResponse>>(
                  cacheKey,
                  async cacheEntry => await _context.Questions
                      .Where(x => x.PollId == pollId && x.IsActive)
                      .Include(x => x.Answers)
                      .Select(q => new QuestionResponse(
                         q.Id,
                          q.Id,
                          q.Content,
                          q.Answers.Where(a => a.IsActive).Select(a => new Contracts.Answer.AnswerResponse(a.Id, a.Content))
                      ))
                      .AsNoTracking()
                      .ToListAsync(cancellationToken)
              );

       return Result.Success(questions!);
   }

//Remove Cach in add update togglestatus
public async Task<Result> ToggleStatusAsync(int pollId, int questionId, CancellationToken cancellationToken = default)
 {
     var question = await _context.Questions.SingleOrDefaultAsync(x => x.PollId == pollId && x.Id == id, cancellationToken);

     if (question is null)
         return Result.Failure(QuestionErrors.QuestionNotFound);

     question.IsActive = !question.IsActive;

     await _context.SaveChangesAsync(cancellationToken);

     await _hybridCache.RemoveAsync($"{_cachePrefix}-{pollId}", cancellationToken);

     return Result.Success();
 }
```


### Registration
``` c#
 //Add RegisterRequestValidator/RegisterRequest
 public record RegisterRequest
(
    string Email
    , string Password
    ,string FirstName,
    string LastName
);

public class RegisterRequestValidator : AbstractValidator<RegisterRequest>
{
    public RegisterRequestValidator()
    {
        RuleFor(x => x.Email)
            .NotEmpty()
            .EmailAddress();

        RuleFor(x => x.FirstName)
          .NotEmpty()
          .Length(3, max: 100);

        RuleFor(x => x.LastName)
        .NotEmpty()
        .Length(3, max: 100);

        RuleFor(x => x.Password)
      .NotEmpty()
       .Matches(RegexPatterns.Password)
            .WithMessage("Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one digit, and one special character.");


    }
}

//Add Email confratin in Email and whatsApp section
//Add mathods in AuthServices (register-ConfirmEmail-ResendConfirmationEmail)
namespace SurveyBasket.Services;
public class AuthService(
    UserManager<ApplicationUser> userManager,
    SignInManager<ApplicationUser> signInManager,
    IJwtProvider jwtProvider,
    ILogger<AuthService> logger,
    IEmailSender emailSender,
    IHttpContextAccessor httpContextAccessor,
    ApplicationDbContext context) : IAuthService
{
    private readonly UserManager<ApplicationUser> _userManager = userManager;
    private readonly SignInManager<ApplicationUser> _signInManager = signInManager;
    private readonly IJwtProvider _jwtProvider = jwtProvider;
    private readonly ILogger<AuthService> _logger = logger;
    private readonly IEmailSender _emailSender = emailSender;
    private readonly IHttpContextAccessor _httpContextAccessor = httpContextAccessor;
    private readonly ApplicationDbContext _context = context;

    private readonly int _refreshTokenExpiryDays = 14;

    public async Task<Result<AuthResponse>> GetTokenAsync(string email, string password, CancellationToken cancellationToken = default)
    {
        if (await _userManager.FindByEmailAsync(email) is not { } user)
            return Result.Failure<AuthResponse>(UserErrors.InvalidCredentials);

        if (user.IsDisabled)
            return Result.Failure<AuthResponse>(UserErrors.DisabledUser);

        var result = await _signInManager.PasswordSignInAsync(user, password, false, true);

        if (result.Succeeded)
        {
            var (userRoles, userPermissions) = await GetUserRolesAndPermissions(user, cancellationToken);

            var (token, expiresIn) = _jwtProvider.GenerateToken(user, userRoles, userPermissions);
            var refreshToken = GenerateRefreshToken();
            var refreshTokenExpiration = DateTime.UtcNow.AddDays(_refreshTokenExpiryDays);

            user.RefreshTokens.Add(new RefreshToken
            {
                Token = refreshToken,
                ExpiresOn = refreshTokenExpiration
            });

            await _userManager.UpdateAsync(user);

            var response = new AuthResponse(user.Id, user.Email, user.FirstName, user.LastName, token, expiresIn, refreshToken, refreshTokenExpiration);

            return Result.Success(response);
        }

        var error = result.IsNotAllowed
            ? UserErrors.EmailNotConfirmed
            : result.IsLockedOut
            ? UserErrors.LockedUser
            : UserErrors.InvalidCredentials;

        return Result.Failure<AuthResponse>(error);
    }

    //public async Task<OneOf<AuthResponse, Error>> GetTokenAsync(string email, string password, CancellationToken cancellationToken = default)
    //{
    //    var user = await _userManager.FindByEmailAsync(email);

    //    if (user is null)
    //        return UserErrors.InvalidCredentials;

    //    var isValidPassword = await _userManager.CheckPasswordAsync(user, password);

    //    if (!isValidPassword)
    //        return UserErrors.InvalidCredentials;

    //    var (token, expiresIn) = _jwtProvider.GenerateToken(user);
    //    var refreshToken = GenerateRefreshToken();
    //    var refreshTokenExpiration = DateTime.UtcNow.AddDays(_refreshTokenExpiryDays);

    //    user.RefreshTokens.Add(new RefreshToken
    //    {
    //        Token = refreshToken,
    //        ExpiresOn = refreshTokenExpiration
    //    });

    //    await _userManager.UpdateAsync(user);

    //    return new AuthResponse(user.Id, user.Email, user.FirstName, user.LastName, token, expiresIn, refreshToken, refreshTokenExpiration);
    //}

    public async Task<Result<AuthResponse>> GetRefreshTokenAsync(string token, string refreshToken, CancellationToken cancellationToken = default)
    {
        var userId = _jwtProvider.ValidateToken(token);

        if (userId is null)
            return Result.Failure<AuthResponse>(UserErrors.InvalidJwtToken);

        var user = await _userManager.FindByIdAsync(userId);

        if (user is null)
            return Result.Failure<AuthResponse>(UserErrors.InvalidJwtToken);

        if (user.IsDisabled)
            return Result.Failure<AuthResponse>(UserErrors.DisabledUser);

        if (user.LockoutEnd > DateTime.UtcNow)
            return Result.Failure<AuthResponse>(UserErrors.LockedUser);

        var userRefreshToken = user.RefreshTokens.SingleOrDefault(x => x.Token == refreshToken && x.IsActive);

        if (userRefreshToken is null)
            return Result.Failure<AuthResponse>(UserErrors.InvalidRefreshToken);

        userRefreshToken.RevokedOn = DateTime.UtcNow;

        var (userRoles, userPermissions) = await GetUserRolesAndPermissions(user, cancellationToken);

        var (newToken, expiresIn) = _jwtProvider.GenerateToken(user, userRoles, userPermissions);
        var newRefreshToken = GenerateRefreshToken();
        var refreshTokenExpiration = DateTime.UtcNow.AddDays(_refreshTokenExpiryDays);

        user.RefreshTokens.Add(new RefreshToken
        {
            Token = newRefreshToken,
            ExpiresOn = refreshTokenExpiration
        });

        await _userManager.UpdateAsync(user);

        var response = new AuthResponse(user.Id, user.Email, user.FirstName, user.LastName, newToken, expiresIn, newRefreshToken, refreshTokenExpiration);

        return Result.Success(response);
    }

    public async Task<Result> RevokeRefreshTokenAsync(string token, string refreshToken, CancellationToken cancellationToken = default)
    {
        var userId = _jwtProvider.ValidateToken(token);

        if (userId is null)
            return Result.Failure(UserErrors.InvalidJwtToken);

        var user = await _userManager.FindByIdAsync(userId);

        if (user is null)
            return Result.Failure(UserErrors.InvalidJwtToken);

        var userRefreshToken = user.RefreshTokens.SingleOrDefault(x => x.Token == refreshToken && x.IsActive);

        if (userRefreshToken is null)
            return Result.Failure(UserErrors.InvalidRefreshToken);

        userRefreshToken.RevokedOn = DateTime.UtcNow;

        await _userManager.UpdateAsync(user);

        return Result.Success();
    }

    public async Task<Result> RegisterAsync(RegisterRequest request, CancellationToken cancellationToken = default)
    {
        var emailIsExists = await _userManager.Users.AnyAsync(x => x.Email == request.Email, cancellationToken);

        if (emailIsExists)
            return Result.Failure(UserErrors.DuplicatedEmail);

        var user = request.Adapt<ApplicationUser>();

        var result = await _userManager.CreateAsync(user, request.Password);

        if (result.Succeeded)
        {
            var code = await _userManager.GenerateEmailConfirmationTokenAsync(user);
            code = WebEncoders.Base64UrlEncode(Encoding.UTF8.GetBytes(code));

            _logger.LogInformation("Confirmation code: {code}", code);

            await SendConfirmationEmail(user, code);

            return Result.Success();
        }

        var error = result.Errors.First();

        return Result.Failure(new Error(error.Code, error.Description, StatusCodes.Status400BadRequest));
    }

    public async Task<Result> ConfirmEmailAsync(ConfirmEmailRequest request)
    {
        if (await _userManager.FindByIdAsync(request.UserId) is not { } user)
            return Result.Failure(UserErrors.InvalidCode);

        if (user.EmailConfirmed)
            return Result.Failure(UserErrors.DuplicatedConfirmation);

        var code = request.Code;

        try
        {
            code = Encoding.UTF8.GetString(WebEncoders.Base64UrlDecode(code));
        }
        catch (FormatException)
        {
            return Result.Failure(UserErrors.InvalidCode);
        }

        var result = await _userManager.ConfirmEmailAsync(user, code);

        if (result.Succeeded)
        {
            await _userManager.AddToRoleAsync(user, DefaultRoles.Member.Name);
            return Result.Success();
        }

        var error = result.Errors.First();

        return Result.Failure(new Error(error.Code, error.Description, StatusCodes.Status400BadRequest));
    }

    public async Task<Result> ResendConfirmationEmailAsync(ResendConfirmationEmailRequest request)
    {
        if (await _userManager.FindByEmailAsync(request.Email) is not { } user)
            return Result.Success();

        if (user.EmailConfirmed)
            return Result.Failure(UserErrors.DuplicatedConfirmation);

        var code = await _userManager.GenerateEmailConfirmationTokenAsync(user);
        code = WebEncoders.Base64UrlEncode(Encoding.UTF8.GetBytes(code));

        _logger.LogInformation("Confirmation code: {code}", code);

        await SendConfirmationEmail(user, code);

        return Result.Success();
    }

    public async Task<Result> SendResetPasswordCodeAsync(string email)
    {
        if (await _userManager.FindByEmailAsync(email) is not { } user)
            return Result.Success();

        if (!user.EmailConfirmed)
            return Result.Failure(UserErrors.EmailNotConfirmed with { StatusCode = StatusCodes.Status400BadRequest });

        var code = await _userManager.GeneratePasswordResetTokenAsync(user);
        code = WebEncoders.Base64UrlEncode(Encoding.UTF8.GetBytes(code));

        _logger.LogInformation("Reset code: {code}", code);

        await SendResetPasswordEmail(user, code);

        return Result.Success();
    }

    public async Task<Result> ResetPasswordAsync(ResetPasswordRequest request)
    {
        var user = await _userManager.FindByEmailAsync(request.Email);

        if (user is null || !user.EmailConfirmed)
            return Result.Failure(UserErrors.InvalidCode);

        IdentityResult result;

        try
        {
            var code = Encoding.UTF8.GetString(WebEncoders.Base64UrlDecode(request.Code));
            result = await _userManager.ResetPasswordAsync(user, code, request.NewPassword);
        }
        catch (FormatException)
        {
            result = IdentityResult.Failed(_userManager.ErrorDescriber.InvalidToken());
        }

        if (result.Succeeded)
            return Result.Success();

        var error = result.Errors.First();

        return Result.Failure(new Error(error.Code, error.Description, StatusCodes.Status401Unauthorized));
    }

    private static string GenerateRefreshToken()
    {
        return Convert.ToBase64String(RandomNumberGenerator.GetBytes(64));
    }

    private async Task SendConfirmationEmail(ApplicationUser user, string code)
    {
        var origin = _httpContextAccessor.HttpContext?.Request.Headers.Origin;

        var emailBody = EmailBodyBuilder.GenerateEmailBody("EmailConfirmation",
            templateModel: new Dictionary<string, string>
            {
                { "{{name}}", user.FirstName },
                    { "{{action_url}}", $"{origin}/auth/emailConfirmation?userId={user.Id}&code={code}" }
            }
        );

        BackgroundJob.Enqueue(() => _emailSender.SendEmailAsync(user.Email!, "✅ Survey Basket: Email Confirmation", emailBody));

        await Task.CompletedTask;
    }

    private async Task SendResetPasswordEmail(ApplicationUser user, string code)
    {
        var origin = _httpContextAccessor.HttpContext?.Request.Headers.Origin;

        var emailBody = EmailBodyBuilder.GenerateEmailBody("ForgetPassword",
            templateModel: new Dictionary<string, string>
            {
                { "{{name}}", user.FirstName },
                { "{{action_url}}", $"{origin}/auth/forgetPassword?email={user.Email}&code={code}" }
            }
        );

        BackgroundJob.Enqueue(() => _emailSender.SendEmailAsync(user.Email!, "✅ Survey Basket: Change Password", emailBody));

        await Task.CompletedTask;
    }

    private async Task<(IEnumerable<string> roles, IEnumerable<string> permissions)> GetUserRolesAndPermissions(ApplicationUser user, CancellationToken cancellationToken)
    {
        var userRoles = await _userManager.GetRolesAsync(user);

        //var userPermissions = await _context.Roles
        //    .Join(_context.RoleClaims,
        //        role => role.Id,
        //        claim => claim.RoleId,
        //        (role, claim) => new { role, claim }
        //    )
        //    .Where(x => userRoles.Contains(x.role.Name!))
        //    .Select(x => x.claim.ClaimValue!)
        //    .Distinct()
        //    .ToListAsync(cancellationToken);

        var userPermissions = await (from r in _context.Roles
                                     join p in _context.RoleClaims
                                     on r.Id equals p.RoleId
                                     where userRoles.Contains(r.Name!)
                                     select p.ClaimValue!)
                                     .Distinct()
                                     .ToListAsync(cancellationToken);

        return (userRoles, userPermissions);
    }
}


```

### Email Api
```c#
//we use mailjet.com
Mailjet.Api Package

//Add the class you want
public class EmailSettings
{

    public const string SectionName = "Mailjet"; 
    [Required] public string ApiKey { get; set; } = string.Empty;
    [Required] public string SecretKey { get; set; } = string.Empty;
    [Required] public string SenderEmail { get; set; } = string.Empty;
    [Required] public string SenderName { get; set; } = string.Empty;
}


//Add in Dipancyinjection with Data
 services.AddScoped<IEmailService, EmailService>();
   services.AddOptions<EmailSettings>()
     .Bind(configuration.GetSection("Mailjet"))
     .ValidateDataAnnotations()
     .ValidateOnStart();


//in the service with intarface 
public class EmailService : IEmailService
{
    // Using in email Api https://app.mailjet.com/account/apikeys

    private readonly EmailSettings _emailSettings;

    public EmailService(IOptions<EmailSettings> options)
    {
        _emailSettings = options.Value;
    }

    public async Task SendEmailAsync(string toEmail, string subject, string body)
    {
        var client = new MailjetClient(_emailSettings.ApiKey, _emailSettings.SecretKey);

        var request = new MailjetRequest
        {
            Resource = Send.Resource,
        }
        .Property(Send.FromEmail, _emailSettings.SenderEmail)
        .Property(Send.FromName, _emailSettings.SenderName)
        .Property(Send.Subject, subject)
        .Property(Send.HtmlPart, body)
        .Property(Send.Recipients, new JArray {
            new JObject { { "Email", toEmail } }
        });

        var response = await client.PostAsync(request);

        if (response.IsSuccessStatusCode)
        {
            Console.WriteLine("Email sent successfully.");
        }
        else
        {
            Console.WriteLine($"Error sending email: {response.StatusCode}\n{response.GetData()}");
        }
    }
}


//In appsettings 
"Mailjet": {
  "ApiKey": "",
  "SecretKey": "",
  "SenderEmail": "mmoo19701@gmail.com",
  "SenderName": "Dev/Ashraf"
}


//Email controller
public class EmailController : ControllerBase
{
    private readonly IEmailService _emailService;

    public EmailController(IEmailService emailService)
    {
        _emailService = emailService;
    }

    [HttpPost("send-email")]
    public async Task<IActionResult> SendEmail([FromBody]EmailRequest request)
    {
        await _emailService.SendEmailAsync(request.ToEmail, request.Subject, request.Body);
        return Ok("Email sent.");
    }
}

//Add this fun in you Services
 private async Task SendConfirmationEmail(ApplicationUser user, string code)
 {
     var origin = _httpContextAccessor.HttpContext?.Request.Headers.Origin;

     var emailBody = EmailBodyBuilder.GenerateEmailBody("EmailConfirmation",
       templateModel: new Dictionary<string, string>
       {
             { "{{name}}", user.FirstName },
                 { "{{action_url}}", $"{origin}/auth/emailConfirmation?userId={user.Id}&code={code}" }
       }
   );

     await _emailService.SendEmailAsync(user.Email!, "✅ Survey Basket: Email Confirmation", emailBody);

     await Task.CompletedTask;
 }

//and add EmailBodyBuilder in Helpers Folder
public static class EmailBodyBuilder
{
    public static string GenerateEmailBody(string template, Dictionary<string, string> templateModel)
    {
        var templatePath = $"{Directory.GetCurrentDirectory()}/Templates/{template}.html";
        var streamReader = new StreamReader(templatePath);
        var body = streamReader.ReadToEnd();
        streamReader.Close();

        foreach (var item in templateModel)
            body = body.Replace(item.Key, item.Value);

        return body;
    }
}
```

### Background Jobs
```c#
//exemple:Monthly sending message for DSL Recipe from vodafone,              send poll notfaction when it by published


//Install-Package
Install-Package Hangfire.Core
Install-Package Hangfire.AspNetCore
Install-Package Hangfire.SqlServer
Install-Package Hangfire.Dashboard.Basic.Authentication



//Add New Db manual 
 "HangfireConnection": "Server=(localdb)\\ProjectModels;Database=SurveyBasketJobs;Trusted_Connection=True;Encrypt=False"

//Add hanfire Username Password in secret.jesone
 "HangfireSettings": {
   "Username": "Admin",
   "Password": "Admin@1234;"
 }
//DepenceiyInjection
  services.AddBackgroundJobsConfig(configuration);
  private static IServiceCollection AddBackgroundJobsConfig(this IServiceCollection services,
        IConfiguration configuration)
    {
        services.AddHangfire(config => config
            .SetDataCompatibilityLevel(CompatibilityLevel.Version_180)
            .UseSimpleAssemblyNameTypeSerializer()
            .UseRecommendedSerializerSettings()
            .UseSqlServerStorage(configuration.GetConnectionString("HangfireConnection")));

        services.AddHangfireServer();

        return services;
    }

//Add in prgram  UseHangfireDashboard
if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
}

app.UseHangfireDashboard("/jobs", new DashboardOptions
{
    Authorization =
    [
        new HangfireCustomBasicAuthenticationFilter
        {
            User = app.Configuration.GetValue<string>("HangfireSettings:Username"),
            Pass = app.Configuration.GetValue<string>("HangfireSettings:Password")
        }
    ],
    DashboardTitle = "Survey Basket Dashboard",
});

//exemple of use it 
// BackgroundJob.Enqueue(()the method));
private async Task SendConfirmationEmail(ApplicationUser user, string code)
    {
        var origin = _httpContextAccessor.HttpContext?.Request.Headers.Origin;

        var emailBody = EmailBodyBuilder.GenerateEmailBody("EmailConfirmation",
            templateModel: new Dictionary<string, string>
            {
                { "{{name}}", user.FirstName },
                    { "{{action_url}}", $"{origin}/auth/emailConfirmation?userId={user.Id}&code={code}" }
            }
        );

        BackgroundJob.Enqueue(() => _emailSender.SendEmailAsync(user.Email!, "✅ Survey Basket: Email Confirmation", emailBody));

        await Task.CompletedTask;}

//secend Exemple
  if (poll.IsPublished && poll.StartsAt == DateOnly.FromDateTime(DateTime.UtcNow))
      BackgroundJob.Enqueue(() => _notificationService.SendNewPollsNotification(poll.Id));
  

//or you want to send Daily message , this in program after IsDevlpment mode
var scopeFactory = app.Services.GetRequiredService<IServiceScopeFactory>();
using var scope = scopeFactory.CreateScope();
var notificationService = scope.ServiceProvider.GetRequiredService<INotificationService>();

RecurringJob.AddOrUpdate("SendNewPollsNotification", () => notificationService.SendNewPollsNotification(null), Cron.Daily);
```

### Pagination & Filtering & sorting 
```c#
//Pagination is a technique used in software development to split large data sets into smaller, manageable pages. This improves both the user experience and performance by reducing the number of records processed or displayed at once.

Install-Package System.Linq.Dynamic.Core

//Add PaginatedList
namespace SurveyManagementSystem.Api.Abstractions;
public class PaginatedList<T>(List<T> items, int pageNumber, int count, int pageSize)
{
    public List<T> Items { get; private set; } = items;
    public int PageNumber { get; private set; } = pageNumber;
    public int TotalPages { get; private set; } = (int)Math.Ceiling(count / (double)pageSize);
    public bool HasPreviousPage => PageNumber > 1;
    public bool HasNextPage => PageNumber < TotalPages;


    public static async Task<PaginatedList<T>> CreateAsync(IQueryable<T> source, int pageNumber, int pageSize, CancellationToken cancellationToken = default)
    {
        var count = await source.CountAsync(cancellationToken);
        var items = await source.Skip((pageNumber - 1) * pageSize).Take(pageSize).ToListAsync(cancellationToken);

        return new PaginatedList<T>(items, pageNumber, count, pageSize);
    }
}

//Add RequestFilters
namespace SurveyManagementSystem.Api.Contracts.Common;
public record RequestFilters
{
    public int PageNumber { get; init; } = 1;
    public int PageSize { get; init; } = 10;
    public string? SearchValue { get; init; }
    public string? SortColumn { get; init; }
    public string? SortDirection { get; init; } = "ASC";
}

//Exemple of Get All question
 public async Task<Result<PaginatedList<QuestionResponse>>> GetAllAsync(int pollId, RequestFilters filters, CancellationToken cancellationToken = default)
 {
     var pollIsExists = await _context.Polls.AnyAsync(x => x.Id == pollId, cancellationToken: cancellationToken);

     if (!pollIsExists)
         return Result.Failure<PaginatedList<QuestionResponse>>(PollErrors.PollNotFound);

     var query = _context.Questions
         .Where(x => x.PollId == pollId);

     if (!string.IsNullOrEmpty(filters.SearchValue))
     {
         query = query.Where(x => x.Content.Contains(filters.SearchValue));
     }

     if (!string.IsNullOrEmpty(filters.SortColumn))
     {
         query = query.OrderBy($"{filters.SortColumn} {filters.SortDirection}");
     }

     var source = query
                     .Include(x => x.Answers)
                     .ProjectToType<QuestionResponse>()
                     .AsNoTracking();

     var questions = await PaginatedList<QuestionResponse>.CreateAsync(source, filters.PageNumber, filters.PageSize, cancellationToken);

     return Result.Success(questions);
 }


//to use it you should put parrmter in postment
```


### Health Check
```c# 
Install-Package AspNetCore.HealthChecks.SqlServer
Install-Package AspNetCore.HealthChecks.UI.Client
Install-Package AspNetCore.HealthChecks.Hangfire

//Add in DepenincyInjection
 services.AddHealthChecks()
            .AddSqlServer(name: "database", connectionString: connectionString!)
            .AddHangfire(options => { options.MinimumAvailableServers = 1; })
            .AddCheck<MailProviderHealthCheck>(name: "mail service");
//Add in Pipline
app.MapHealthChecks("health", new HealthCheckOptions
{
    ResponseWriter = UIResponseWriter.WriteHealthCheckUIResponse
});
app.Run();
```

### RateLimiting
```c#
//In program
app.UseRateLimiter();

//Add class RateLimiters in Abstractions
namespace SurveyManagementSystem.Api.Abstractions;
public static class RateLimiters
{
    public const string IpLimiter = "ipLimit";
    public const string UserLimiter = "userLimit";
    public const string Concurrency = "concurrency";
}

//in DependcyIjection
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
           
            rateLimiterOptions.AddConcurrencyLimiter(RateLimiters.Concurrency, options =>
            {
                options.PermitLimit = 1000;
                options.QueueLimit = 100;
                options.QueueProcessingOrder = QueueProcessingOrder.OldestFirst;
            });

           
        });

        return services;
    }



```


### Api Versining
```c#
Install-Package Asp.Versioning.Http
Install-Package Asp.Versioning.Mvc.ApiExplorer

//DependinyInjection
services.AddApiVersioning(options =>
        {
            options.DefaultApiVersion = new ApiVersion(1.0);
            options.AssumeDefaultVersionWhenUnspecified = true;
            options.ReportApiVersions = true;

            options.ApiVersionReader = new HeaderApiVersionReader("x-api-version");
        })
        .AddApiExplorer(options =>
        {
            options.GroupNameFormat = "'v'V";
            options.SubstituteApiVersionInUrl = true;
        });


```


### OpenApi
``` c#
//DependincyInjection
private static IServiceCollection AddOpenApiServices(this IServiceCollection services)
   {
       var serviceProvider = services.BuildServiceProvider();
       var apiVersionDescriptionProvider = serviceProvider.GetRequiredService<IApiVersionDescriptionProvider>();

       foreach (var description in apiVersionDescriptionProvider.ApiVersionDescriptions)
       {
           services.AddOpenApi(description.GroupName, options =>
           {
               options.AddDocumentTransformer<BearerSecuritySchemeTransformer>();
               options.AddDocumentTransformer(new ApiVersioningTransformer(description));
           });
       }

       return services;
   }

//Useing swagger Ui with  opent api
Install-Package Swashbuckle.AspNetCore.SwaggerUI
if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();

    app.UseSwaggerUI(options =>
        {
            var descriptions = app.DescribeApiVersions();
            foreach (var description in descriptions)
            {
                options.SwaggerEndpoint($"/swagger/{description.GroupName}/swagger.json", description.GroupName.ToUpperInvariant());
            }
        }
    );
}


//Using with open Api
Install-Package Scalar.AspNetCore

if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
    app.MapScalarApiReference();
}
```


### small note
- cancellation token




### Role 
``` c#
//Add two column  in AspnetRoles
public class ApplicationRole : IdentityRole
{
    public ApplicationRole()
    {
        Id = Guid.CreateVersion7().ToString();
    }

    public bool IsDefault { get; set; }
    public bool IsDeleted { get; set; }
}

//Update IdentityRole in Dependies to be ApplicationRole

//Create Seed:in folder Abstractions.Consts
//Add  DefaultRoles
namespace SurveyBasket.Abstractions.Consts;
public static class DefaultRoles
{
    public partial class Admin
    {
        public const string Name = nameof(Admin);
        public const string Id = "0191a4b6-c4fc-752e-9d95-40b5e4e68054";
        public const string ConcurrencyStamp = "0191a4b6-c4fc-752e-9d95-40b631d1866d";
    }

    public partial class Member
    {
        public const string Name = nameof(Member);
        public const string Id = "0191a4b6-c4fc-752e-9d95-40b7a5cb88f0";
        public const string ConcurrencyStamp = "0191a4b6-c4fc-752e-9d95-40b85cf3fd22";
    }
}

//Add Defult User
namespace SurveyBasket.Abstractions.Consts;
public static class DefaultUsers
{
    public partial class Admin
    {
        public const string Id = "0191a4b6-c4fc-752e-9d95-40b30fa7a9b6";
        public const string Email = "admin@survey-basket.com";
        public const string PasswordHash = "AQAAAAIAAYagAAAAEKRku5u6K325Irl1Utujiuil/WUhjTvShS9mJLXxO+2v/GKrMT1Ofhdp/0taFUO2bA==";
        public const string SecurityStamp = "55BF92C9EF0249CDA210D85D1A851BC9";
        public const string ConcurrencyStamp = "0191a4b6-c4fc-752e-9d95-40b42a925b8e";
    }
}

//to make Usr create when open the project Add Defult Data in user configrations
public class UserConfiguration : IEntityTypeConfiguration<ApplicationUser>
{
    public void Configure(EntityTypeBuilder<ApplicationUser> builder)
    {
        // builder.HasIndex(x => new { x.QuestionId, x.Content }).IsUnique();

        builder
            .OwnsMany(x => x.RefreshTokens)
            .ToTable("RefreshToken")
            .WithOwner()
            .HasForeignKey("UserId");

        builder.Property(x => x.FirstName).HasMaxLength(100);
        builder.Property(x => x.LastName).HasMaxLength(100);



        //Default Data
        builder.HasData(new ApplicationUser
        {
            Id = DefaultUsers.Admin.Id,
            FirstName = "Survey Basket",
            LastName = "Admin",
            UserName = DefaultUsers.Admin.Email,
            NormalizedUserName = DefaultUsers.Admin.Email.ToUpper(),
            Email = DefaultUsers.Admin.Email,
            NormalizedEmail = DefaultUsers.Admin.Email.ToUpper(),
            SecurityStamp = DefaultUsers.Admin.SecurityStamp,
            ConcurrencyStamp = DefaultUsers.Admin.ConcurrencyStamp,
            EmailConfirmed = true,
            PasswordHash = DefaultUsers.Admin.PasswordHash
        });

    }


//Then add RoleConfiguration
namespace SurveyBasket.Persistence.EntitiesConfigurations;
public class RoleConfiguration : IEntityTypeConfiguration<ApplicationRole>
{
    public void Configure(EntityTypeBuilder<ApplicationRole> builder)
    {
        //Default Data
        builder.HasData([
            new ApplicationRole
            {
                Id = DefaultRoles.Admin.Id,
                Name = DefaultRoles.Admin.Name,
                NormalizedName = DefaultRoles.Admin.Name.ToUpper(),
                ConcurrencyStamp = DefaultRoles.Admin.ConcurrencyStamp
            },
            new ApplicationRole
            {
                Id = DefaultRoles.Member.Id,
                Name = DefaultRoles.Member.Name,
                NormalizedName = DefaultRoles.Member.Name.ToUpper(),
                ConcurrencyStamp = DefaultRoles.Member.ConcurrencyStamp,
                IsDefault = true
            }
        ]);
    }
}

//then add UserRoleConfiguration 
namespace SurveyBasket.Persistence.EntitiesConfigurations;
public class UserRoleConfiguration : IEntityTypeConfiguration<IdentityUserRole<string>>
{
    public void Configure(EntityTypeBuilder<IdentityUserRole<string>> builder)
    {
        //Default Data
        builder.HasData(new IdentityUserRole<string>
        {
            UserId = DefaultUsers.Admin.Id,
            RoleId = DefaultRoles.Admin.Id
        });
    }
}

//then add RoleClaimConfiguration 
namespace SurveyBasket.Persistence.EntitiesConfigurations;

public class RoleClaimConfiguration : IEntityTypeConfiguration<IdentityRoleClaim<string>>
{
    public void Configure(EntityTypeBuilder<IdentityRoleClaim<string>> builder)
    {
        //Default Data
        var permissions = Permissions.GetAllPermissions();
        var adminClaims = new List<IdentityRoleClaim<string>>();

        for (var i = 0; i < permissions.Count; i++)
        {
            adminClaims.Add(new IdentityRoleClaim<string>
            {
                Id = i + 1,
                ClaimType = Permissions.Type,
                ClaimValue = permissions[i],
                RoleId = DefaultRoles.Admin.Id
            });
        }

        builder.HasData(adminClaims);
    }
}

//Add permission in Jwt token
public class JwtProvider(IOptions<JwtOptions> options) : IJwtProvider
{
    private readonly JwtOptions _options = options.Value;

    
    public (string token, int expiresIn) GenerateToken(ApplicationUser user, IEnumerable<string> roles, IEnumerable<string> permissions)
    {
        Claim[] claims = new Claim[]
        {
            new(JwtRegisteredClaimNames.Sub,user.Id),
            new(JwtRegisteredClaimNames.Email,user.Email!),
            new(JwtRegisteredClaimNames.GivenName,user.FirstName),
            new(JwtRegisteredClaimNames.FamilyName,user.LastName),
            new(JwtRegisteredClaimNames.Jti,Guid.CreateVersion7().ToString()),
            new(nameof(roles),JsonSerializer.Serialize(roles),JsonClaimValueTypes.JsonArray),
            new(nameof(permissions),JsonSerializer.Serialize(permissions),JsonClaimValueTypes.JsonArray)
        };

        var symmetricSecurityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_options.Key));

        var signingCredentials = new SigningCredentials(symmetricSecurityKey, SecurityAlgorithms.HmacSha256);



        var token = new JwtSecurityToken(
            issuer: _options.Issuer,
            audience: _options.Audience,
            claims: claims,
            expires: DateTime.UtcNow.AddMinutes(_options.ExpiryMinutes),
            signingCredentials: signingCredentials
            );

        return (token: new JwtSecurityTokenHandler().WriteToken(token), expiresIn: _options.ExpiryMinutes);


    }

    public string? ValidateToken(string token)
    {
        var TokenHandler = new JwtSecurityTokenHandler();

        var symmetricSecurityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_options.Key));

        try
        {
            TokenHandler.ValidateToken(token, new TokenValidationParameters
            {
                IssuerSigningKey = symmetricSecurityKey,
                ValidateIssuerSigningKey = true,
                ValidateIssuer = false,
                ValidateAudience = false,
                ClockSkew = TimeSpan.Zero
            }, out SecurityToken validatedToken);

            var jwtToken = (JwtSecurityToken)validatedToken;

            return jwtToken.Claims.First(x => x.Type == JwtRegisteredClaimNames.Sub).Value;
        }
        catch
        {

            return null;
        }

    }
}

//Exemple of role
[HttpGet("current")]
[Authorize(Roles = DefaultRoles.Member.Name)]
public async Task<IActionResult> GetCurrent(CancellationToken cancellationToken)
   {
       return Ok(await _pollService.GetCurrentAsync(cancellationToken));
   }

```

### Pirmission 
```c#
//Add Permission in costs
namespace SurveyBasket.Abstractions.Consts;
public static class Permissions
{
    public static string Type { get; } = "permissions";

    public const string GetPolls = "polls:read";
    public const string AddPolls = "polls:add";
    public const string UpdatePolls = "polls:update";
    public const string DeletePolls = "polls:delete";

    public const string GetQuestions = "questions:read";
    public const string AddQuestions = "questions:add";
    public const string UpdateQuestions = "questions:update";

    public const string GetUsers = "users:read";
    public const string AddUsers = "users:add";
    public const string UpdateUsers = "users:update";

    public const string GetRoles = "roles:read";
    public const string AddRoles = "roles:add";
    public const string UpdateRoles = "roles:update";

    public const string Results = "results:read";

    public static IList<string?> GetAllPermissions() =>
        typeof(Permissions).GetFields().Select(x => x.GetValue(x) as string).ToList();
}

//Add folder in SurveyBasket/Authentication/Filters

//Add PermissionRequirement
namespace SurveyBasket.Authentication.Filters;
public class PermissionRequirement(string permission) : IAuthorizationRequirement
{
    public string Permission { get; } = permission;
}

//add HasPermissionAttribute
public class HasPermissionAttribute(string permission) : AuthorizeAttribute(permission)
{
}
//Add PermissionAuthorizationHandler
namespace SurveyBasket.Authentication.Filters;
public class PermissionAuthorizationHandler : AuthorizationHandler<PermissionRequirement>
{
    protected override async Task HandleRequirementAsync(AuthorizationHandlerContext context, PermissionRequirement requirement)
    {
        //var user = context.User.Identity;

        //if(user is null || !user.IsAuthenticated)
        //    return;

        //var hasPermission = context.User.Claims.Any(x => x.Value == requirement.Permission && x.Type == Permissions.Type);

        //if(!hasPermission) 
        //    return;

        if (context.User.Identity is not { IsAuthenticated: true } ||
            !context.User.Claims.Any(x => x.Value == requirement.Permission && x.Type == Permissions.Type))
            return;

        context.Succeed(requirement);
        return;
    }
}

//Add  PermissionAuthorizationPolicyProvider
namespace SurveyBasket.Authentication.Filters;
public class PermissionAuthorizationPolicyProvider(IOptions<AuthorizationOptions> options)
    : DefaultAuthorizationPolicyProvider(options)
{
    private readonly AuthorizationOptions _authorizationOptions = options.Value;

    public override async Task<AuthorizationPolicy?> GetPolicyAsync(string policyName)
    {
        var policy = await base.GetPolicyAsync(policyName);

        if (policy is not null)
            return policy;

        var permissionPolicy = new AuthorizationPolicyBuilder()
            .AddRequirements(new PermissionRequirement(policyName))
            .Build();

        _authorizationOptions.AddPolicy(policyName, permissionPolicy);

        return permissionPolicy;
    }
}

//Add in Add Dependincy injection
  services.AddTransient<IAuthorizationHandler, PermissionAuthorizationHandler>();
        services.AddTransient<IAuthorizationPolicyProvider, PermissionAuthorizationPolicyProvider>();

//Permission exemple
 [HttpGet("")]
 [HasPermission(Permissions.GetPolls)]
 public async Task<IActionResult> GetAll(CancellationToken cancellationToken)
     => Ok(await _pollService.GetAllAsync());


```

### RoleMangment
```c#
//Add ,RoleService
public class RoleService(RoleManager<ApplicationRole> roleManager,ApplicationDbContext context) : IRoleService
{
    private readonly RoleManager<ApplicationRole> _roleManager = roleManager;
    private readonly ApplicationDbContext _context = context;

    public async Task<IEnumerable<RoleResponse>> GetAllAsync(bool includeDisabled = false, CancellationToken cancellationToken = default)
    {
        return await _roleManager.Roles
            .Where(x => !x.IsDefault && (!x.IsDeleted || includeDisabled))
            .ProjectToType<RoleResponse>()
            .ToListAsync(cancellationToken);

    }

    public async Task<Result<RoleDetailResponse>> GetAsync(string id)
    {
        if (await _roleManager.FindByIdAsync(id) is not { } role)
            return Result.Failure<RoleDetailResponse>(RoleErrors.RoleNotFound);

        var permissions = await _roleManager.GetClaimsAsync(role);

        var response = new RoleDetailResponse(role.Id, role.Name!, role.IsDeleted, permissions.Select(x => x.Value));

        return Result.Success(response);

    }

    public async Task<Result<RoleDetailResponse>> AddAsync(RoleRequest request)
    {
        if (!await _roleManager.RoleExistsAsync(request.Name))
            return Result.Failure<RoleDetailResponse>(RoleErrors.DuplicatedRole);

        var allowedPermissions = Permissions.GetAllPermissions();

        if(request.Permissions.Except(allowedPermissions).Any())
            return Result.Failure<RoleDetailResponse>(RoleErrors.InvalidPermissions);

        var role = new ApplicationRole
        {
            Name = request.Name,
            ConcurrencyStamp = Guid.CreateVersion7().ToString()
        };

        var result = await _roleManager.CreateAsync(role);

        if(result.Succeeded)
        {
            var permissions = request.Permissions
                .Select(x => new IdentityRoleClaim<string>
                {
                    ClaimType = Permissions.Type,
                    ClaimValue = x,
                    RoleId = role.Id
                });

            await _context.AddRangeAsync(permissions);
            await _context.SaveChangesAsync();

            var response = new RoleDetailResponse(role.Id, role.Name, role.IsDeleted, request.Permissions);
            return Result.Success(response);
        }


        var error = result.Errors.First();

        return Result.Failure<RoleDetailResponse>(new Error(error.Code, error.Description, StatusCodes.Status400BadRequest));
    }

    public async Task<Result> UpdateAsync(string id, RoleRequest request)
    {
        var roleIsExists = await _roleManager.Roles.AnyAsync(x => x.Name == request.Name && x.Id != id);

        if (roleIsExists)
            return Result.Failure<RoleDetailResponse>(RoleErrors.DuplicatedRole);

        if (await _roleManager.FindByIdAsync(id) is not { } role)
            return Result.Failure<RoleDetailResponse>(RoleErrors.RoleNotFound);

        var allowedPermissions = Permissions.GetAllPermissions();

        if (request.Permissions.Except(allowedPermissions).Any())
            return Result.Failure<RoleDetailResponse>(RoleErrors.InvalidPermissions);

        role.Name = request.Name;

        var result = await _roleManager.UpdateAsync(role);

       


        var error = result.Errors.First();

        return Result.Failure<RoleDetailResponse>(new Error(error.Code, error.Description, StatusCodes.Status400BadRequest));
    }

    public async Task<Result> ToggleStatusAsync(string id)
    {
        if (await _roleManager.FindByIdAsync(id) is not { } role)
            return Result.Failure<RoleDetailResponse>(RoleErrors.RoleNotFound);

        role.IsDeleted = !role.IsDeleted;

        await _roleManager.UpdateAsync(role);

        return Result.Success();
    }


//Add IRoleService
public interface IRoleService
{
    Task<IEnumerable<RoleResponse>> GetAllAsync(bool includeDisabled = false, CancellationToken cancellationToken = default);
    Task<Result<RoleDetailResponse>> GetAsync(string id);
    Task<Result<RoleDetailResponse>> AddAsync(RoleRequest request);
    Task<Result> UpdateAsync(string id, RoleRequest request);
    Task<Result> ToggleStatusAsync(string id);
}


```
### UserMangmet 
```c#
//Add UserService and his interface
```

# steps in make single class
1. fill main Entitles
2. add AuditableEntity if need 
3. make crud in services
4. make resposne and request if need
5. make  valdiator and confirgration
6. 




AuthServices:Login, Register, ConfirmEamil,ResendConfirmEmail
Frogert Password,GerReafreshToken,ResetPasswrod
Polls: CrudOperations,Get Current IN TODEY
Questin: CrudOperations, 
Answer: CrudOperations, 
votes: Add , start
Resutl:Get VOTES RESULT ,BY DAY , BY QUESTIN
profile mangment
roles:Crud optration
users:Crud optration,UnlokcUser


**License Management**:Local and international license applications, License renewals and replacements for damaged licenses,est requests and retake tests,License reservations,Tracking of application statuses and associated fees

Driver & user mngmetn :Crud 





 */