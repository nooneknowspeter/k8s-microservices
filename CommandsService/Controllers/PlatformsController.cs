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

    [HttpPost]
    public ActionResult TestInboundConnection()
    {
      Console.WriteLine("Inbound POST # Commands Service");

      return Ok("Inbound Succesful");
    }

  }
}
