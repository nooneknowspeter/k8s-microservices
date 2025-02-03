using Microsoft.AspNetCore.Mvc;

namespace CommandsService.Controllers
{
  // different route for now to prevent clashing with
  // PlatformsController from the PlatformsService
  [Route("/api/commands/[controller]")]
  [ApiController]
  public class PlatformsController : ControllerBase
  {

    public PlatformsController()
    {

    }

  }
}
