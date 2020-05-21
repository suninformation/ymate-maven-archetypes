#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package}.impl;

import ${package}.EchoServiceCfg;
import ${package}.IEchoService;
import net.ymate.platform.core.beans.annotation.Inject;
import net.ymate.port.core.annotation.PortService;
import org.apache.commons.lang3.StringUtils;

/**
 * IEchoService Interface Default Implementation.
 *
 * @author YMP (https://www.ymate.net/)
 */
@PortService
public class EchoServiceImpl implements IEchoService {

    @Inject
    private EchoServiceCfg serviceCfg;

    @Override
    public String echo(String message) {
        String echoStr = message;
        if (StringUtils.isBlank(echoStr)) {
            echoStr = serviceCfg.getString("echo_str", "None");
        }
        return "Echo: " + echoStr;
    }
}
