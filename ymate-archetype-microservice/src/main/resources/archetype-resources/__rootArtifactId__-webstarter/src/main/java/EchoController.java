#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package};

import net.ymate.platform.webmvc.annotation.Controller;
import net.ymate.platform.webmvc.annotation.RequestMapping;
import net.ymate.platform.webmvc.annotation.RequestParam;
import net.ymate.platform.webmvc.view.IView;
import net.ymate.platform.webmvc.view.View;
import net.ymate.port.core.annotation.PortReference;

/**
 * Echo Controller
 *
 * @author YMP (https://www.ymate.net/)
 */
@Controller
@RequestMapping("/echo")
public class EchoController {

    @PortReference
    private IEchoService echoService;

    @RequestMapping("/")
    public IView echo(@RequestParam String message) throws Exception {
        return View.textView(echoService.echo(message));
    }
}
