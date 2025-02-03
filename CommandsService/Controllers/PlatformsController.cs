using Microsoft.AspNetCore.Mvc;

namespace CommandsService.Controllers
{
  // different route for now to prevent clashing with
  // PlatformController from the PlatformsService
  [Route("/api/commands/[controller]")]
  [ApiController]
  public class PlatformController : ControllerBase
  {

  }
}
