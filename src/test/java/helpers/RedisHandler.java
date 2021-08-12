package helpers;

import com.google.protobuf.InvalidProtocolBufferException;
import com.haud.bifrost.protobuf.RouteOuterClass.Routes;

import redis.clients.jedis.Jedis;

public class RedisHandler {
    private static String ipAddress="192.168.20.22";
    private static String password="password123";

    public static byte[] getRedisData(String key){

        Jedis jedis  = new Jedis(ipAddress, 16379);
        try{
		    jedis.auth(password);
            byte[] bs=jedis.get(key.getBytes());
            Routes routes=Routes.parseFrom(bs);
            System.out.println("Routes count : "+routes.getAllRoutePlansCount());
            return bs;
        }
        catch(NullPointerException e) {
			e.printStackTrace();
		} catch (InvalidProtocolBufferException e) {
            e.printStackTrace();
        }
        finally {
			jedis.close();
		}
        return null;
    }
    
}
